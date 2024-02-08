
import java.io.BufferedReader;
import java.io.Console;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Locale;
import java.util.Random;
import java.util.Scanner; 


 


public class Main{

    static Random generator;
    static ArrayList<String> names = new ArrayList<String>();


    



  static String[] baseServices =  {
                                        "food",
                                        "water",
                                        "fuel",
                                        "data center",
                                        "passes"
                                    };
    static String[] communityServices = {
                                        "movie theatre",
                                        "mining company",
                                        "power company",
                                        "factory", 
                                        "mechanic",
                                        "clothing shop",
                                        "trade depot",
                                        "used ships",
                                        "new ships",
                                        "cartographer",
                                        "church",
                                        "casino",
                                        "tavern",
                                        "restaurant",
                                        "gift shop",
                                        "weapon shop",
                                        "radio shack",
                                        };

    static int[][] enneagramCombos = {
                                        {1,4,7},
                                        {1,7,4},
                                        {2,4,8},
                                        {2,8,4},
                                        {3,6,9},
                                        {3,9,6},
                                        {4,1,2},
                                        {4,2,1},
                                        {5,7,8},
                                        {5,8,7},
                                        {6,9,3},
                                        {6,3,9},
                                        {7,1,5},
                                        {7,5,1},
                                        {8,2,5},
                                        {8,5,2},
                                        {9,3,6},
                                        {9,6,3},
                                        };
    static int[][] enneagramCompat = {
                                        {1,2,9},
                                        {2,4,8},
                                        {3,1,9},
                                        {4,2,9},
                                        {5,1},
                                        {6,8,9,2},
                                        {7,5,1},
                                        {8,2,9},
                                        {9,4,6}
                                        };
    static int[][] enneagramNonCompat = {
                                        {7},
                                        {},
                                        {},
                                        {8},
                                        {9},
                                        {},
                                        {},
                                        {4},
                                        {5}
                                        };

    static <T> T pickRandom(T[] array) {
        int rnd = generator.nextInt(array.length);
        return array[rnd];
    }
    static <T> T pickRandomAL(ArrayList<T> array) {
        int rnd = generator.nextInt(array.size());
        return array.get(rnd);
    }

    static boolean includes(int[] array, int val){
        for (int element : array) {
            if (element == val) {
                return true;
            }
        }
        return false;
    }


    static class Place{
        public int est = 0;
        public String name = "example";
        public int value = 0;

        ArrayList<NPC> residents;
        String[] services;
        String[] neighbors;
        NPC[] popular;
        NPC[] unpopular;
        int startingNumber = 0;


        public Place(String iName, int iStartingNumber){
            name = iName;
            startingNumber = iStartingNumber;
            residents = addRandomCharacters(startingNumber);
            //TODO
        }

        public Place(String iName){
            name = iName;
            startingNumber = generator.nextInt(100);
            residents = addRandomCharacters(startingNumber);
            //TODO
        }
        public Place(){
            name = (generator.nextFloat()<.5) ? pickRandomAL(names) + "'s " + pickRandomAL(names) : pickRandomAL(names)+"ton";
            startingNumber = generator.nextInt(100);
            residents = addRandomCharacters(startingNumber);

            //TODO
            print();
        }



        public void print(){

            System.out.println(">>>>>>>>"+this.name+": "+this.startingNumber+" ");

            for(NPC npc: this.residents){
                System.out.println(npc.name);
            }
        }

        public int increaseAge(){
            return est++;
        }

        public ArrayList<NPC> addRandomCharacters(int iStartingNumber){

            //TODO

            ArrayList<NPC> temp = new ArrayList<NPC>();

            for(int i = 0; i< iStartingNumber; i++){
                temp.add(new NPC());
            }

            return temp;
        }

        public String[] getServices(){

            //TODO
            return services;
        }

        public void step(){
            for(NPC npc: this.residents){
                npc.interact(pickRandomAL(this.residents));
            }
        }

    }
    
    static class NPC{

        String name = "examplePerson";
        int age = 0;
        int[] enneagram = {1,4,7};
        int happiness = 100;
        int boredom = 50;



        ArrayList<String> memories = new ArrayList<String>();
        ArrayList<String> thoughts = new ArrayList<String>();
        ArrayList<String> knowledge = new ArrayList<String>();
        ArrayList<String> friends = new ArrayList<String>();
        ArrayList<String> enemies = new ArrayList<String>();
        String icon = "";


        String home = "This Base";
        String[] travels = {"This Base"};

        public NPC(){
            name = pickRandomAL(names);
            enneagram = pickRandom(enneagramCombos);
            age = generator.nextInt(85) + 15;
            //TODO
        }


        public void interact(NPC interactee) {
            //TODO
            int myType = this.enneagram[0];
            int yourType = interactee.enneagram[0];

            boolean FirstTime = false;

            if(!(this.knowledge.contains(interactee.name)&&interactee.knowledge.contains(this.name))){
                this.knowledge.add(interactee.name);
                interactee.knowledge.add(this.name);

                this.happiness += 2;
                interactee.happiness += 2;

                this.boredom -= 2;
                interactee.boredom -=2;

                FirstTime = true;
            }

            if(includes(enneagramNonCompat[myType-1], yourType)){
                if(FirstTime){
                    this.enemies.add(interactee.name);
                }

                this.thoughts.add(this.name + " had a negative experience interacting with "+interactee.name);
                interactee.thoughts.add(interactee.name + " had a negative experience interacting with "+this.name);

                this.happiness -= 5;
                interactee.happiness -= 3;

                this.boredom -= 1;
                interactee.boredom -= 1;

                System.out.println(this.name + " had a negative experience interacting with "+interactee.name);
                
            }
            else if(includes(enneagramCompat[myType-1], yourType)){
                if(FirstTime){
                    this.friends.add(interactee.name);
                }

                this.thoughts.add(this.name + " had a positive experience interacting with "+interactee.name);
                interactee.thoughts.add(interactee.name + " had a positive experience interacting with "+this.name);

                this.happiness += 5;
                interactee.happiness += 3;

                this.boredom -= 2;
                interactee.boredom -= 2;

                System.out.println(this.name + " had a positive experience interacting with "+interactee.name);
                
            }
            else{
                this.boredom += 3;
                interactee.boredom += 3;
                this.thoughts.add(this.name + " didn't feel anything while interacting with "+interactee.name);

                System.out.println(this.name + " didn't feel anything while interacting with "+interactee.name);
                
            }
        }

        public void cleanup(){
            //TODO
        }
    
    }
    
    static class Character extends NPC{
        
    }

    public static void main(String[] args) throws IOException{
        generator = new Random();
        Scanner s = null;
        try {
            s = new Scanner(new BufferedReader(new FileReader("name.txt")));
            s.useLocale(Locale.US);
            s.useDelimiter(",\\s*");
            while(s.hasNext()){
                names.add(s.next());
            }
        } finally {
            s.close();
        }

        Place p = new Place();

        p.step();

        System.out.println(p.residents.get(1).thoughts.toString());

    }
}