groups = Group.all
contacts = Contact.all

contacts.each do |contact|
  selected_groups = groups.sample(3)

  selected_groups.each do |group|
    ContactGroup.create(contact_id: contact.id, group_id: group.id)
  end
end