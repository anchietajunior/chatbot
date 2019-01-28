require 'open-uri'
require 'nokogiri'
require 'json'

module Lita
  module Handlers
    class Liturgy < Handler
      route(/salmo/, 
        :daily_liturgy,
        command: true,
        help: { "daily_liturgy" => "respond with daily liturgy" }
      )

      def daily_liturgy
        response.reply psalm
      end

      def psalm
        url = 'https://liturgia.cancaonova.com/pb/'
        html = open(url)
        doc = Nokogiri::HTML(html)
        say_it = ""
        doc.css("#liturgia-2").children.each do |element|
          say_it << "#{element.inner_html} \n "
        end
        say_it
      end

      Lita.register_handler(self)
    end
  end
end