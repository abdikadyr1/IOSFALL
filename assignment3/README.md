Shopping cart (Struct vs Class)
At first glance, the task was simple: build a shopping cart. I thought would be a quick coding exercise turned into a deep dive into the 'why' behind Swift's rules. It forced me to ask a fundamental question: what's just a piece of data, and what has a real, tangible identity?

The Case of the Disappearing Items
My first roadblock came almost immediately. I built the ShoppingCart as a struct, thinking it was just a list of items. I'd pass it to a function to add a new product, run the code, and... nothing. The original cart stubbornly remained empty. It felt like trying to edit a shared document, only to find out I was writing on a new photocopy every single time.

That was the lightbulb moment. A user's cart isn't a photocopy; it's a single, shared thing that follows them around. It has an identity. It had to be a class.

The moment I switched it to a class, everything clicked. I was no longer passing around disposable copies, but a link to the one and only cart. Suddenly, every change I made from any part of the code stuck. The whole system was finally talking to the same cart, and it just worked. That's the magic of reference types.

This project was full of small but mighty discoveries. When I first tried to change a CartItem's quantity, the compiler yelled at me until I added the mutating keyword. It was Swift's way of making me stop and think, "Are you sure you want to change this value?" It’s a brilliant little safeguard.

I also fell in love with private(set). It let me show the world what was in the cart, but kept the power to change it locked safely inside the ShoppingCart class. It was like having a display window with a locked door—perfect for keeping the code organized and safe from accidental changes.
