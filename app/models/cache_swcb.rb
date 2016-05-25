class CacheSwcb < CacheOffering

  def as_json(options={})
    opts = { :methods => [:identify],
             :only => [:procedure,:beginTime,:endTime]}
    super(options.merge(opts))
  end

  def identify
    offering
  end

end
