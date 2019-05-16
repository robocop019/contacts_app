class Api::ContactsController < ApplicationController
  def index
    if current_user
      @contacts = current_user.contacts

      first_name_search = params[:first_name]
      all_search = params[:search]

      if all_search
        @contacts = @contacts.where(
                                    "first_name iLIKE ? OR last_name iLIKE ? OR email iLIKE ? OR phone_number iLIKE ? OR bio iLIKE ?", 
                                    "%#{all_search}%", 
                                    "%#{all_search}%", 
                                    "%#{all_search}%", 
                                    "%#{all_search}%", 
                                    "%#{all_search}%"
                                    )
      end

      if first_name_search
        @contacts = @contacts.where("first_name iLIKE ?", "%#{first_name_search}%")
      end

      @contacts = @contacts.order(:id)

      render 'index.json.jbuilder'
    else
      render json: []
    end
  end

  def create
    @contact = Contact.new(
                          first_name: params[:first_name],
                          middle_name: params[:middle_name],
                          last_name: params[:last_name],
                          email: params[:email],
                          phone_number: params[:phone_number],
                          bio: params[:bio],
                          user_id: current_user.id
                          )

    if @contact.save
      render 'show.json.jbuilder'
    else
      render json: {message: @contact.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def show
    @contact = Contact.find(params[:id])
    render 'show.json.jbuilder'
  end

  def update
    @contact = Contact.find(params[:id])

    @contact.first_name = params[:first_name] || @contact.first_name
    @contact.last_name = params[:last_name] || @contact.last_name
    @contact.middle_name = params[:middle_name] || @contact.middle_name
    @contact.email = params[:email] || @contact.email
    @contact.phone_number = params[:phone_number] || @contact.phone_number
    @contact.bio = params[:bio] || @contact.bio

    if @contact.save
      render 'show.json.jbuilder'
    else
      render json: {message: @contact.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    render json: {message: "The contact has been deleted."}
  end
end