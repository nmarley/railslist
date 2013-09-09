class IpAddressString < String
  def to_xml
    "<ip_address>#{self.to_s}</ip_address>"
  end
end

class IpEchoController < ApplicationController

  def echo
    @remote_addr = get_remote_addr
    respond_to do |format|
      format.text { render text: @remote_addr }
      format.xml  { render xml:  @remote_addr.to_xml }
      format.json { render json: @remote_addr.to_json }
    end
  end

  private

  def get_remote_addr
    remote_addr = 
    if request.env.has_key? 'HTTP_X_REAL_IP' &&
      !request.env['HTTP_X_REAL_IP'].empty?
      request.env['HTTP_X_REAL_IP']
    else
      request.remote_ip
    end
    IpAddressString.new remote_addr
  end

# proxy_set_header X-Real-IP $remote_addr;
# proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
#request.remote_ip
#@remote_ip = request.env["HTTP_X_REAL_IP"]
#@remote_ip = request.env["HTTP_X_FORWARDED_FOR"]
  #  my $req = request;
  #  my $ip  = $req->header('X-Real-IP');
  #  return $ip ? $ip :
  #        exists($ENV{REMOTE_ADDR}) ? $ENV{REMOTE_ADDR} : '';

end

__END__
From your controller:

request.remote_ip

If you are using apache in front of a mongrel, then remote_ip will return the source address of the request, which in this case will be local host because the Apache web server is making the request, so instead put this in your controller:

@remote_ip = request.env["HTTP_X_FORWARDED_FOR"]

