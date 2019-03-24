
module Molecule

  module Controller
    extend ActiveSupport::Concern

    included do
      include Molecule::Renderers::Base
    end
  end

end
