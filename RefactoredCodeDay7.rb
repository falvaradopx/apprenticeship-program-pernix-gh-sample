# Clase para representar una orden
class Order
    def initialize(items, email_service)
      @items = items
      @email_service = email_service
    end
  
    # Método para calcular el total usando una estrategia de cálculo
    def calculate_total(strategy = DefaultPricingStrategy.new)
      strategy.calculate(@items)
    end
  
    # Método para enviar un correo de confirmación
    def send_confirmation_email
      @email_service.send_email("customer@example.com", "Order Confirmation", "Thank you for your order!")
    end
  
    # Método para imprimir la orden
    def print_order
      @items.each do |item|
        puts "Item: #{item.name} - Price: #{item.price}"
      end
    end
end
  
class Item
    attr_accessor :name, :price
  
    def initialize(name, price)
      @name = name
      @price = price
    end
end
  
# Estrategia por defecto para calcular el precio total
class DefaultPricingStrategy
    def calculate(items)
      items.sum(&:price)
    end
end
  
# Estrategia para aplicar un descuento porcentual
class PercentageDiscountStrategy
    def initialize(discount_percentage)
      @discount_percentage = discount_percentage
    end
  
    def calculate(items)
      total = items.sum(&:price)
      total - (total * @discount_percentage / 100.0)
    end
end
  
# Estrategia para un descuento fijo
class FixedDiscountStrategy
    def initialize(discount_amount)
      @discount_amount = discount_amount
    end
  
    def calculate(items)
      total = items.sum(&:price)
      [total - @discount_amount, 0].max
    end
end
  
# Servicio para enviar correos electrónicos
class EmailService
    def send_email(to, subject, body)
      # Aquí se implementaría la lógica real para enviar el correo
      puts "Email enviado a #{to} con asunto '#{subject}'"
    end
end