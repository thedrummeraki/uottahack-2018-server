class AuthApiController < ApplicationController

  before_action :check_auth_token

  def cancel_ticket
    ticket_code = params[:ticket_code].to_s.strip
    invalid = ticket_code.empty?
    reason = 'Missing ticket code.'
    unless invalid
        ticket = Ticket.find_by ticket_code: ticket_code
        invalid = ticket.nil?
        reason = "The ticket \"#{ticket_code}\" was not found. Please try again." if invalid
    end
    if invalid
        render json: {
            success: false,
            message: 'Please refer to the documentation at https://github.com/thedrummeraki/uottahack-2018-server.',
            reason: reason
        }
    else
        success = ticket.cancel
        message = "Sorry, but we could not cancel this ticket (#{ticket_code}) due to an internal error. Please try again later." unless success
        render json: {
            success: success,
            ticket_code: ticket_code,
            message: message
        }
    end
  end

  def add_ticket
     ticket_code = params[:ticket_code].to_s.strip
     if ticket_code.empty?
        render json: {
            success: false,
            message: "Please specify the ticket code with your parameters.",
            ready: "No ticket code"
        }
        return
     end

     if Ticket.find_by(ticket_code: ticket_code)
        render json: {
            success: false,
            message: "The ticket \"#{ticket_code}\" has already been added. Please add another one.",
            ready: "Duplicate ticket"
        }
        return
     end

     ticket = Ticket.create ticket_code: ticket_code
     render json: {
        success: !ticket.nil?,
        ticket: ticket
     }
  end

  def increment_ticket
     current_ticket = Ticket.current
     if current_ticket.nil?
        render json: {
            success: false,
            message: "There are no tickets at the moment and therefore going to the next ticket is impossible. Please try again after at least one unused ticket has been used.",
            reason: "No tickets exist on the system",
            url: "/api/tickets/new?auth_token=your-token"
        }
        return
     end
     
     next_tickets = Ticket.mark_next_as_used
     errors = next_tickets.errors unless next_tickets.nil?
     success = !errors.nil? && errors.to_a.empty?
     message = "Could not save the next ticket as used" unless success
     render json: {
        success: success,
        message: message,
        errors: errors.to_a
     }
  end

  def current_number
     current = Ticket.current
     render json: {
        success: !current.nil?,
        ticket: current
     }
  end

  private

  def check_auth_token
    auth_token = params[:auth_token]
    if auth_token.nil?
      render json: {
          success: false,
          message: 'Please refer to the documentation at https://github.com/thedrummeraki/uottahack-2018-server.',
          reason: 'Missing authentication token.'
      }
      return
    end

    response = {}
    unless ClientSession.exists auth_token
      render json: {
          success: false,
          reason: 'The provided token does not exist anymore.',
          message: 'Please refer to the documentation at https://github.com/thedrummeraki/uottahack-2018-server.'
      }
    end
  end
end
