module API
  module Order
    extend API::Restful

    STATUST = {
      unpaid:     0,    # 创建未支付
      paid:       1,    # 已支付
      approval:   2,    # 订单审核通过
      unshipped:  14,   # 订单准备发货
      shipped:    15,   # 订单已发货
      received:   16,   # 用户已签收
      rejected:   10    # 用户拒收
    }

    class << self
      def index(req, params = {})
        post(req, params.merge(path: 'order/my'))
      end

      def create(req, params = {})
        post(req, params.merge(path: 'product/order'))
      end

      def show(req, params = {})
        post(req, params.merge(path: 'order/detail'))
      end

      def destory(req, params = {})
        post(req, params.merge(path: 'order/void'))
      end

      def update(req, params = {})
        post(req, params.merge(path: 'order/rma'))
      end

      def new(req, params = {})
        post(req, params.merge(path: 'product/detail4p'))
      end

      # 计算 运费 总积分 总金额 商品价格
      def computeamount(req, params = {})
        post(req, params.merge(path: 'product/computeamount'))
      end

      # 订单能否取消
      def can_cancel?(statust)
        STATUST.values_at(:unpaid, :paid, :approval).map(&:to_s).include?(statust.to_s)
      end

      # 能否支付
      def can_payment?(statust)
        STATUST[:unpaid].to_s == statust.to_s
      end
    end
  end
end
