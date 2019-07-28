# frozen_string_literal: true.
##
# Shop is the app central model.
# @since v0
#
class Shop < ApplicationRecord
  validates :name, presence: true

  # String version of the instance (using +name+).
  # @return [String]
  #
  alias_attribute :to_s, :name
end
