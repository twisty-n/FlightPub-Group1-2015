
class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :account_status, :address, :role
  has_many :journeys

  def journeys

    object.saved_journeys.each do |saved_journey|
        SavedJourneySerializer.new( saved_journey )
    end
  end
end


=begin
export default DS.Model.extend({
    email:          DS.attr('string'),
    firstName:      DS.attr('string'),
    lastName:       DS.attr('string'),
    bio:            DS.attr('string'),
    accountStatus:  DS.attr('string')
});
=end
