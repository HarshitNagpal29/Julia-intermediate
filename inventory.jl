mutable struct Item
    name::String
    price::Float64
    quantity::Int
end

inventory = Item[]

println("Enter 1 to add an item to the inventory.")
println("Enter 2 to remove an item from the inventory.")
println("Enter 3 to display the inventory.")
println("Enter 4 to update the quantity of an item.")
println("Enter 5 to exit the program.")

global choice = readline()


function add_item!(inventory, name, price, quantity)
    isempty(name) && error("Item name cannot be empty.")
    price < 0 && error("Price must be non-negative.")
    quantity < 0 && error("Quantity must be non-negative.")
    push!(inventory, Item(name, price, quantity))
end

function remove_item(inventory, name)
    original_size = length(inventory)
    filter!(item -> item.name != name, inventory)
    if length(inventory) == original_size
        error("No item found with name: $name")
    end
    return name
end

function display_inventory(inventory)
    isempty(inventory) && println("No items in inventory.") && return
    println("Inventory List:")
    for item in inventory
        println("Name: $(item.name), Price: $(item.price), Quantity: $(item.quantity)")
    end
end

function update_quantity!(inventory, name, quantity)
    quantity < 0 && error("Quantity must be non-negative.")
    for item in inventory
        if item.name == name
            item.quantity = quantity
            return
        end
    end
    error("No item found with name: $name")
end

while choice != "5"
    if choice == "1"
        println("Enter the name of the item:")
        name = readline()
        println("Enter the price of the item:")
        price = parse(Float64, readline())
        println("Enter the quantity of the item:")
        quantity = parse(Int, readline())
        add_item!(inventory, name, price, quantity)
    elseif choice == "2"
        println("Enter the name of the item to remove:")
        name = readline()
        remove_item(inventory, name)
    elseif choice == "3"
        display_inventory(inventory)
    elseif choice == "4"
        println("Enter the name of the item to update:")
        name = readline()
        println("Enter the new quantity of the item:")
        quantity = parse(Int, readline())
        update_quantity!(inventory, name, quantity)
    else
        println("Invalid choice. Please try again.")
    end
    println("Enter 1 to add an item to the inventory.")
    println("Enter 2 to remove an item from the inventory.")
    println("Enter 3 to display the inventory.")
    println("Enter 4 to update the quantity of an item.")
    println("Enter 5 to exit the program.")
    global choice = readline() 
end
println("Exiting program.")