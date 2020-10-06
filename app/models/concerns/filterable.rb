module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter_by(filtering_params)
      results = self.where(nil)
      filtering_params.each do |key, value|
        value = value.map{ |v| v.to_i if v.is_i? } if value.kind_of?(Array) # value is array of ints?
        results = results.public_send(key, value) if value.present?
      end
      results
    end
  end
end
