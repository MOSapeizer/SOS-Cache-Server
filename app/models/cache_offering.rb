class CacheOffering < ActiveRecord::Base
	has_many :observations
  has_many :offering_prorperty_ships
  has_many :offering_feature_ships
  has_many :features, through: :offering_feature_ships
	has_many :observed_properties, through: :offering_prorperty_ships

  validates :offering, :procedure, :beginTime, :endTime, presence: true

  def as_json(options={})
    opts = { :methods => [:identify],
             :only => [:procedure,:beginTime,:endTime],
             :include =>
                 { :features =>
                       { only: [:name, :longitude, :latitude] },
                   :observed_properties =>
                       { only: [:property] }
                 }
    }
    super(options.merge(opts))
  end

  def identify
    offering
  end

end
