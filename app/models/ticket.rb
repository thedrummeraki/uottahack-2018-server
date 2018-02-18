class Ticket < ApplicationRecord

    before_save :set_ticket_count
    before_save :check_in_use
    before_save :ensure_ticket_has_code

    def wait_time
        if self.in_use
            h = rand(3); m = rand(60)
            a = true
        else
            h = nil; m = nil; a = false
        end
        {hours: h, mins: m, approximate: a}
    end

    def mark_used
        self.update_attributes in_use: true
    end

    def cancel
        self.update_attributes in_use: false
    end

    def next(trials: 100)
        return nil if self.class.last.id == self.id
        current_id = id
        count = 0
        while true
            current_id += 1
            ticket = self.class.find_by id: current_id
            return ticket unless ticket.nil?
            unless trials.nil?
                if count >= trials
                    p "Could not find a ticket after looking for #{trials} ticket(s)."
                    return nil
                end
            end
            count += 1
        end
    end

    def self.current
        return nil if self.last.nil?
        current_id = self.last.id
        found_ticket = nil
        while current_id >= 0
            ticket = self.find_by id: current_id
            unless found_ticket.nil?
                ticket.cancel unless ticket.nil?
            end
            if found_ticket.nil? && !ticket.nil? && ticket.in_use
                found_ticket = ticket
                current_id -= 1
                next
            end
            current_id -= 1
        end
        return found_ticket unless found_ticket.nil?
        self.first.mark_used
        self.first
    end

    def self.mark_next_as_used
        ticket = self.current
        return nil if ticket.nil?
        next_ticket = ticket.next
        unless next_ticket.nil?
            ticket.cancel
            next_ticket.mark_used
        end
        next_ticket.nil? ? ticket : next_ticket
    end

    private

    def ensure_ticket_has_code
        if self.ticket_code.to_s.strip.empty?
            self.errors.add "ticket_code", "cannot empty."
        end
    end

    def set_ticket_count
        self.ticket_count = self.id
    end

    def check_in_use
        if self.in_use.nil?
            self.in_use = true
        end
    end

end
