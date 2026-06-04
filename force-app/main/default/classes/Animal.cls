// virtual it allows inheritance and method overriding

public virtual class Animal {
	public String name;
    
    public Animal(String name){
        this.name = name;
    }
    
    public virtual void makeSound(){
		system.debug('Animal makes a sound');
    }
}