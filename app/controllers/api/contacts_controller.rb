class Api::ContactsController < ApplicationController
  def first_contact_action
    @contact = Contact.first
    render 'contact_view.json.jbuilder'
  end

  def all_contacts_action
    @contacts = Contact.all
    render 'all_contacts_view.json.jbuilder'
  end
end
