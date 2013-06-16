require 'spec_helper'
require 'pry'

class Fruit
    def ignite(nearby_fruit = nil)
        @is_burned = true
        nearby_fruit.ignite if nearby_fruit
    end

    def burned?
        @is_burned
    end
end

class Apple < Fruit; end
class Strawberry < Fruit; end

class SimpleBddNamedNounsExample
    include SimpleBdd
end

describe SimpleBddNamedNounsExample do

    let_named!(:apple, :fruit) { Apple.new }
    let_named!(:strawberry, :fruit) { Strawberry.new }

    it "Apples burn strawberries" do
        Given "Apple is on fire" # calls apple_is_on_fire
        Then "Strawberry gets burned" # calls fruit_gets_burned
    end

    it "Strawberries burn strawberries" do
        Given "Strawberry is on fire" # calls fruit_is_on_fire
        Then "Strawberry gets burned" # calls fruit_gets_burned
    end

    def apple_is_on_fire
        apple.ignite(strawberry)
    end

    def fruit_is_on_fire opts
        opts[:fruit].ignite    
    end

    def fruit_gets_burned opts
        opts[:fruit].burned?.should be_true
    end
end
