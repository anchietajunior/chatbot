require 'open-uri'
require 'nokogiri'
require 'sanitize'

module Lita
  module Handlers
    class Liturgy < Handler
      
      DEFAULT_URL = 'https://liturgia.cancaonova.com/pb/'
      DOC = Nokogiri::HTML(open(url)) 

      route(/salmo/, 
        :daily_liturgy,
        command: true,
        help: { "daily_liturgy" => "respond with daily liturgy" }
      )

      def daily_liturgy response
        response.reply psalm
      end

      def psalm
        say_it = doc.css("#liturgia-2").children.each { |element| say_it << Sanitize.fragment("#{element.inner_html} \n ") }
      end

      Lita.register_handler(self)
    end
  end
end