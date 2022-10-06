# frozen_string_literal: true

module Queries
  class CheapestSailing
    attr_accessor :shipping_options, :origin_port, :destination_port, :direct

    # AVAILABLE_PORTS = ['CNSHA', 'NLRTM', 'ESBCN','BRSSZ']

    def initialize(shipping_options, origin_port, destination_port, direct)
      @sailings = shipping_options
      @origin_port = origin_port
      @destination = destination_port
      @min_date = Date.new(1970)
      @sailings = direct ? only_direct(@sailings) : @sailings
    end

    def call
      if all_routes.any?
        all_routes.map { |el| { price: el.sum { |h| h[:price] }, path: el } }.min_by { |el| el[:price] }[:path]
      else
        []
      end
    end

    def all_routes
      base = []
      first_ports.each_with_index do |option, i|
        base << [option]
        next if option[:destination_port] == @destination

        next_cheapest_options = cheapest_options(@sailings, option[:destination_port], option[:origin_port],
                                                 option[:arrival_date])
        next_cheapest_options.each do |opt|
          base[i] << opt

          next if option[:destination_port] == @destination

          again_cheapest_options = cheapest_options(@sailings, opt[:destination_port], opt[:origin_port],
                                                    opt[:arrival_date])
          again_cheapest_options.each do |optt|
            base[i] << optt
          end
        end
      end
      # remove dead ends
      base.select { |el| el.last[:d] == @d }
    end

    def first_ports
      cheapest_options(@sailings, @origin_port, @origin_port, @min_date)
    end

    def cheapest_options(sailings, origin_port, no_return_to, min_date)
      choose_cheapest(next_ports(sailings, origin_port, no_return_to, min_date.to_date))
    end

    def next_ports(sailings, origin_port, no_return_to, min_date)
      # selects next available ports: doesn't take returning trips
      # takes only the sailings that are available after the arrival time of the previous sailing
      sailings.select do |el|
        el[:origin_port] == origin_port &&
          el[:destination_port] != no_return_to &&
          el[:departure_date].to_date > min_date
      end
    end

    def choose_cheapest(sailings)
      # group sailings by [origin_port, destination port]
      # if there are more than one, chose with the lowest price in euro
      # prices are precalculated and saved into sailings in the normalizer
      sailings.group_by { |el| [el['origin_port'], el['destination_port']] }.values.map do |el|
        el.min_by do |k|
          k[:price]
        end
      end
    end

    def only_direct(sailings)
      sailings.select { |el| el[:origin_port] == @origin_port && el[:destination_port] == @destination }
    end
  end
end
