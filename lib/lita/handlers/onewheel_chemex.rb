module Lita
  module Handlers
    class OnewheelChemex < Handler
      route /^chemex fresh$/i,
            :chemex_fresh,
            command: true,
            help: {'!chemex fresh' => 'Report a fresh chemex pour.'}
      route /^chemex$/i,
            :chemex_report,
            command: true,
            help: {'!chemex' => 'See when the last chemex was poured.'}
      route /^chemex reset$/i,
            :chemex_reset,
            command: true,
            help: {'!chemex reset' => 'Reset it when the chemex is empty.'}

      def chemex_fresh(response)
        redis.set('chemex', Time.now)
        response.reply 'Fresh chemex is available now!'
      end

      def chemex_report(response)
        chemex_date = redis.get('chemex')
        if chemex_date.to_s == ''
          response.reply old_chemex_message
          return
        end

        chemex_age = Time::parse chemex_date
        if chemex_age.to_i < Time.now.to_i - 7200

        end
        response.reply "The chemex was brewed at #{chemex_age.strftime('%H:%M:%S')}"
      end

      def old_chemex_message
        'Chemex is old and cold; make a new one!'
      end

      def chemex_reset(response)
        redis.set('chemex', nil)
      end
    end

    Lita.register_handler(OnewheelChemex)
  end
end
