require 'rubygems'
require 'log4r'
require 'uuid'
require File.join(File.dirname(__FILE__), '..', 'model', 'order')

class OrderValidator
  attr_accessor :errors

  def initialize(logger = Log4r::Logger['MainLogger'], uuid_generator = UUID.new)
    @uuid_generator = uuid_generator
    @logger = logger
    @errors = {}
  end

  def validate(params)
    @logger.debug("Validating order")
    @errors.clear
    setup(params)
    @is_valid = file_is_valid?    
    @logger.debug("order valid=" + @is_valid.to_s)
  end

  def is_valid?
    @is_valid
  end

  def bind
    order = Order.new
    order.file_id = @uuid_generator.generate
    order.file_name = @file_name
    order
  end

  private
  def setup(params)
    @file = params[:file]
    @temp_file = params[:file][:tempfile] if params[:file]
    @file_name = params[:file][:filename] if params[:file]
  end

  def file_is_valid?
    unless @file && @temp_file && @file_name
      @errors.merge!({:file => "Please select a file to upload"})
      return false
    end
    unless is_psd?()
      @errors.merge!({:file => "Only Photoshop (psd) files can be uploaded"})
      return false
    end

    return true
  end

  def is_psd?
    @file_name.chomp(".psd").length == @file_name.length - 4
  end

end