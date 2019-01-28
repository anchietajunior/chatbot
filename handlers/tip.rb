module Lita
  module Handlers
    class Tip < Handler
      route(/tip[s|z] (\d*){1}/i,
        :say_tip,
        command: true,
        help: { "tips <num>" => "replies with some tips" }
      )

      def say_tip response
        tips = response.args.first.to_i

        if tips > 1
          response.reply "Wow! Are you sure you wanna #{tips} tips!?"
        else
          response.reply "Drink some watter!"
        end
      end

      Lita.register_handler(self)
    end
  end
end