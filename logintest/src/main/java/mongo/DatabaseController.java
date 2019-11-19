package mongo;

import com.mongodb.MongoClient;
import com.mongodb.DBCollection;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;

public class DatabaseController {
    
    private static MongoClient client = null;
    
    public static void connect(String ip)
    {
        try
        {
            client = new MongoClient(ip, 27017);
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }
    
    public static void close()
    {
        client.close();
    }
    
    // Form name will be the unique URL for consumers to follow
    // TODO should the unique URL be passed into this function or returned
    //  by this method?
    public static String addNewForm(String formName, String json)
    {
        DBCollection col = null;
        BasicDBObject obj = null;
        
        if(client == null)
        {
            System.out.println("Connection not established.");
            return null;
        }
        
        col = client.getDB("forms").getCollection("published_forms");
        obj = new BasicDBObject();
        
        obj.put(formName, json);
        col.insert(obj);
        
        return "";
    }
    
    public static void addSubmission(String formName, String json, String formJson, String url)
    {
        DBCollection col = null;
        DBObject form = null;
        BasicDBObject query, newDoc, update = null;
        
        if(client == null)
        {
            System.out.println("Connection not established.");
            return;
        }
        
        col = client.getDB("forms").getCollection("published_forms");
        form = new BasicDBObject();
        form.put(url, json);
        
        query = new BasicDBObject();
        query.put(formName, formJson);
        
        newDoc = new BasicDBObject();
        newDoc.put(url, form);
        
        update = new BasicDBObject();
        update.put("$set", newDoc);
        
        //form = col.findOne(formName);
        //obj = new BasicDBObject();
        
//        obj.put(url, json);
//        form.put("sub1", obj);
//        col.insert(obj);

        col.update(query, update);
    }
    
    public static MongoClient getClient()
    {
        return client;
    }
    
    public static void main(String[] args) {
        MongoClient mongoClient = null;
        DBCollection col;
        BasicDBObject obj;
        
        try {
            //mongoClient = new MongoClient( /*"192.168.137.1"*/ "localhost", 27017 );
            
            connect("localhost");
 
            if(client != null)
                System.out.println("Connected to MongoDB!");
            
            System.out.println("Attempting to add to DB...");
            //col = client.getDB("test_collection").getCollection("Persons");
            //addNewForm("testForm3", "formjson");
            //addNewForm("whydoesntthisadd", "formjson2");
            addSubmission("testForm2", "subjson i love coding", "json", "0x21");
            addSubmission("testForm3", "subjson", "formjson", "0x35167");
            
            /*obj = new BasicDBObject();
            obj.put("anything", "test person");
            obj.put("else", "test country");
            col.insert(obj);*/
            System.out.println("Success : )");
            
            close();
            
        } catch (Exception e) {
            e.printStackTrace();
        }       
    }
}