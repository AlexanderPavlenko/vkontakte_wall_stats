require 'vkontakte_wall_stats/version'
require 'date'
require 'vkontakte_api'

module VkontakteWallStats

  MAX_COUNT = 100
  REQUEST_DELAY = 0.35

  def self.stats(owner_id: nil, domain: nil, filter: :all)
    VkontakteApi.configure do |config|
      config.logger = Logger.new(STDERR)
      config.api_version = '5.27'
    end
    raise ArgumentError unless owner_id || domain
    vk = VkontakteApi::Client.new
    params = {
      filter: filter,
      offset: 0,
      count: MAX_COUNT,
    }
    params[:owner_id] = owner_id if owner_id
    params[:domain] = domain if domain
    result = Hash.new { |h, k| h[k] = 0 }
    loop do
      batch = vk.wall.get(params)
      break if batch.items.empty?
      params[:offset] += MAX_COUNT
      batch.items.each do |item|
        next if item.is_pinned
        result[Time.at(item.date).to_date] += 1
      end
      sleep REQUEST_DELAY
    end
    result
  end

  def self.serialize_result(result)
    result.to_a.sort_by!(&:first).each_with_object('') { |i, a|
      a.concat "#{i[0].to_s};#{i[1]}\n"
    }
  end
end
