class CacheSwcb < CacheOffering

  def as_json(options={})
    opts = { :methods => [:id],
             :only => [:procedure,:beginTime,:endTime]}
    super(options.merge(opts))
  end

  def id
    offering
  end


end
