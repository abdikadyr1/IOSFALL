import Foundation


struct Product {
    let id: String
    let name: String
    let price: Double
    let category: Category
    let description: String

    
    enum Category: String {
        case electronics = "Electronics"
        case clothing = "Clothing"
        case food = "Food"
        case books = "Books"
    }

    
    
    var displayPrice: String {
        return String(format: "$%.2f", price)
    }
 
    
    init?(id: String, name: String, price: Double, category: Category, description: String) {
    
        guard price > 0 else {
            print("Error: Product price must be positive.")
            return nil
        }
        
        self.id = id
        self.name = name
        self.price = price
        self.category = category
        self.description = description
    }
}


struct CartItem {
    let product: Product
    private(set) var quantity: Int

    
    var subtotal: Double {
        return product.price * Double(quantity)
    }
    
    
    init(product: Product, quantity: Int) {
        self.product = product
        self.quantity = max(1, quantity)
    }

    mutating func updateQuantity(_ newQuantity: Int) {
        if newQuantity > 0 {
            self.quantity = newQuantity
        } else {
            print("Warning: Quantity must be greater than 0. Not updated.")
        }
    }
    
    mutating func increaseQuantity(by amount: Int) {
        self.quantity += amount
    }
}

class ShoppingCart {
    
    private(set) var items: [CartItem] = []
    var discountCode: String?

    
    var subtotal: Double {
        return items.reduce(0) { $0 + $1.subtotal }
    }

    
    var discountAmount: Double {
        guard let code = discountCode else { return 0 }
        
        
        if code == "SAVE10" {
            return subtotal * 0.10
        } else if code == "SAVE20" {
            return subtotal * 0.20
        }
        return 0
    }
    
  
    var total: Double {
        return subtotal - discountAmount
    }
    
    
    var itemCount: Int {
        return items.reduce(0) { $0 + $1.quantity }
    }
    
    var isEmpty: Bool {
        return items.isEmpty
    }

    func addItem(product: Product, quantity: Int = 1) {
        
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
           
            items[index].increaseQuantity(by: quantity)
        } else {
            
            let newItem = CartItem(product: product, quantity: quantity)
            items.append(newItem)
        }
    }

    func removeItem(productId: String) {
        items.removeAll { $0.product.id == productId }
    }

    func updateItemQuantity(productId: String, quantity: Int) {
        if let index = items.firstIndex(where: { $0.product.id == productId }) {
            if quantity > 0 {
                items[index].updateQuantity(quantity)
            } else {
              
                removeItem(productId: productId)
            }
        }
    }
    
    func clearCart() {
        items.removeAll()
    }
}

struct Address {
    let street: String
    let city: String
    let zipCode: String
    let country: String
    
    var formattedAddress: String {
        return """
        \(street)
        \(city), \(zipCode)
        \(country)
        """
    }
}

struct Order {
    let orderId: String
    let items: [CartItem]
    let subtotal: Double
    let discountAmount: Double
    let total: Double
    let timestamp: Date
    let shippingAddress: Address
    
    
    init(from cart: ShoppingCart, shippingAddress: Address) {
        self.orderId = UUID().uuidString
        self.items = cart.items
        self.subtotal = cart.subtotal
        self.discountAmount = cart.discountAmount
        self.total = cart.total
        self.timestamp = Date()
        self.shippingAddress = shippingAddress
    }
    
    var itemCount: Int {
        return items.reduce(0) { $0 + $1.quantity }
    }
}

func runAllTests() {

    guard let laptop = Product(id: "prod-001", name: "M2 MacBook Pro", price: 1299.99, category: .electronics, description: "A powerful laptop."),
          let book = Product(id: "prod-002", name: "Swift Programming", price: 49.95, category: .books, description: "The Big Nerd Ranch Guide."),
          let headphones = Product(id: "prod-003", name: "Noise Cancelling Headphones", price: 249.50, category: .electronics, description: "Listen without distraction.")
    else {
        print("Failed to initialize products. Exiting.")
        return
    }

    let cart = ShoppingCart()
    cart.addItem(product: laptop, quantity: 1)
    cart.addItem(product: book, quantity: 2)
    print("\n[Test 2] Added laptop and 2 books. Item count: \(cart.itemCount)") // Expected: 3

    
    cart.addItem(product: laptop, quantity: 1)
    print("[Test 3] Added another laptop. Item count: \(cart.itemCount)") // Expected: 4
    if let laptopItem = cart.items.first(where: { $0.product.id == "prod-001" }) {
        print("   -> Laptop quantity is now: \(laptopItem.quantity)") // Expected: 2
    }

    
    print("\n[Test 4] Cart Calculations:")
    print(String(format: "   -> Subtotal: $%.2f", cart.subtotal))

    
    cart.discountCode = "SAVE10"
    print("\n[Test 5] Applied 'SAVE10' discount:")
    print(String(format: "   -> Discount Amount: $%.2f", cart.discountAmount))
    print(String(format: "   -> Total with discount: $%.2f", cart.total))

    
    cart.removeItem(productId: book.id)
    print("\n[Test 6] Removed all books. Item count: \(cart.itemCount)") // Expected: 2

    
    print("\n[Test 7] Demonstrating Reference Type (ShoppingCart class):")
    func modifyCart(_ copyCart: ShoppingCart) {
        print("   -> Inside function, adding headphones...")
        copyCart.addItem(product: headphones, quantity: 1)
    }
    print("   -> Cart item count BEFORE function call: \(cart.itemCount)")
    modifyCart(cart)
    print("   -> Cart item count AFTER function call: \(cart.itemCount)") // Expected: 3

    
    print("\n[Test 8] Demonstrating Value Type (CartItem struct):")
    let item1 = CartItem(product: laptop, quantity: 1)
    var item2 = item1
    item2.updateQuantity(5)
    print("   -> item1 quantity: \(item1.quantity)") // Expected: 1
    print("   -> item2 quantity: \(item2.quantity)") // Expected: 5
    print("   -> item1 quantity: \(item1.quantity)") // Expected: 1
    
    let shippingAddress = Address(street: "Tole Bi 59", city: "Almaty", zipCode: "050000", country: "Qazaqstan")
    let order = Order(from: cart, shippingAddress: shippingAddress)
    print("\n[Test 9] Created an order from the cart.")
    print("   -> Order contains \(order.itemCount) items.")
 
    print("\n[Test 10] Demonstrating Order Immutability:")
    print("   -> Clearing the original cart now...")
    cart.clearCart()
    print("   -> Order items count: \(order.itemCount)") // Expected: 0 <
    print("   -> Cart items count: \(cart.itemCount)")   // Expected: 0
    
    print("\n--- All Tests Completed ---\n")
}

runAllTests()
