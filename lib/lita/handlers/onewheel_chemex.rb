module Lita
  module Handlers
    class OnewheelChemex < Handler
      route /chemex fresh/i, :chemex_fresh, command: true, help: 'Report a fresh chemex pour.'
      route /chemex/i, :chemex_report, command: true, help: 'See when the last chemex was poured.'

      def chemex_fresh(response)
        redis.set('chemex', Time.now)
        response.reply 'Fresh chemex is available now!'
      end

      def chemex_report(response)
        chemex_age = Time::parse redis.get('chemex')
        response.reply chemex_age.strftime('%H:%M:%S')
      end
    end

    Lita.register_handler(OnewheelChemex)
  end
end
