Dir[ File.dirname(__FILE__) + "/fes/expression/*.rb"].each {|file| require file }
Dir[ File.dirname(__FILE__) + "/fes/comparisonOps/*.rb"].each {|file| require file }
Dir[ File.dirname(__FILE__) + "/fes/extensionOps/*.rb"].each {|file| require file }
Dir[ File.dirname(__FILE__) + "/fes/logicOps/*.rb"].each {|file| require file }
Dir[ File.dirname(__FILE__) + "/fes/spatialOps/*.rb"].each {|file| require file }
Dir[ File.dirname(__FILE__) + "/fes/temporalOps/*.rb"].each {|file| require file }