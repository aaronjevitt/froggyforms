package mongo;

import com.mongodb.MongoClient;
import com.mongodb.MongoException;
import com.mongodb.DBCollection;
import com.mongodb.BasicDBObject;
import com.mongodb.BasicDBObjectBuilder;
 
/**
* Created by TutorialKart on 31/10/17.
*/
public class MongoTest {
    public static void main(String[] args) {
        MongoClient mongoClient = null;
        DBCollection col;
        BasicDBObject obj;
        
        try {
            mongoClient = new MongoClient( "192.168.137.1" , 27017 );
 
            System.out.println("Connected to MongoDB!");
            
            System.out.println("Attempting to add to DB...");
            col = mongoClient.getDB("test_collection").getCollection("Persons");
            
            obj = new BasicDBObject();
            obj.put("anything", "test person");
            obj.put("else", "test country");
            col.insert(obj);
            System.out.println("Success : )");
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            mongoClient.close();
        }        
    }
}