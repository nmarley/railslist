class IpAddressString < String
  def to_xml
    "<ip_address>#{self.to_s}</ip_address>"
  end
end

class IpEchoController < ApplicationController

  def echo
    @remote_addr = get_remote_addr
    respond_to do |format|
      format.json { render json: @remote_addr.to_json }
      format.text { render text: @remote_addr }
      format.xml  { render xml:  @remote_addr.to_xml }
    end
  end

  private

  def get_remote_addr
    remote_addr = request.env.fetch('HTTP_X_REAL_IP', nil)
    remote_addr ||= request.remote_ip
    remote_addr ||= ''
    IpAddressString.new remote_addr
  end
end

