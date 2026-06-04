public class Dog extends Animal{
    // here super is calling the Parent (i.e animal) class constructor;
    public Dog(String name){
        super(name);
    }
    
    // here we are overriding the method of parent class with override keyword.
    public override void makeSound(){
		system.debug(name + ' makes sound');
    }
}