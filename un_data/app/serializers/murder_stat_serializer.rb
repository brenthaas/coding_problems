class MurderStatSerializer < ActiveModel::Serializer
  attributes :id, :year, :count, :rate, :country_name

  def country_name
    object.country.name
  end
end
