require 'rubygems'
require 'UPnP/control/device'
require 'UPnP/control/service/content_directory'
require 'UPnP/control/service/connection_manager'
require 'pp'

class UPnP::Control::Device::MediaServer < UPnP::Control::Device

  VERSION = '1.0.0'

  URN_1 = [UPnP::DEVICE_SCHEMA_PREFIX, name.split(':').last, 1].join ':'

  def browse_children(id)
    content_directory.Browse id, "BrowseDirectChildren", "*", "0", "0", ""
  end

  def get_metadata(container_id)
    content_directory.Browse container_id, "BrowseMetadata", "", "0", "0", ""
  end

  def get_root
    content_directory.Browse "0", "BrowseDirectChildren", "", "0", "0", ""
  end

  def get_directories
    pp get_root
  end

  def content_directory
    @cd ||= services.find do |service|
      service.type == UPnP::Control::Service::ContentDirectory::URN_1
    end
    @cd
  end

  def connection_manager
    @cm ||= services.find do |service|
      service.type == UPnP::Control::Service::ConnectionManager::URN_1
    end
    @cm
  end


end
