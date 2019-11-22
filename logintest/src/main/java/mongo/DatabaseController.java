package mongo;

import com.mongodb.MongoClient;
import com.mongodb.DBCollection;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import com.mongodb.DBCursor;
import com.mongodb.DB;

public class DatabaseController {
    
    private MongoClient client = null;
    
    public void connect(String ip)
    {
        try
        {
            client = new MongoClient(ip, 27017);
            System.out.println("Connected to " + ip);
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }
    
    public void close()
    {
        client.close();
        System.out.println("Disconnecting");
    }
    
    // Form name will be the unique URL for consumers to follow
    // TODO should the unique URL be passed into this function or returned
    //  by this method?
    public void addNewForm(String url, String json)
    {
        DBCollection col = null;
        BasicDBObject obj = null;
        
        if(client == null)
        {
            System.out.println("Connection not established.");
            return;
        }
        
        col = client.getDB("forms").getCollection("published_forms");
        obj = new BasicDBObject();
        
        obj.put("unique_url", url);
        obj.put("form_json", json);
        col.insert(obj);
    }
    
    public void addSubmission(String url, String json, int submissionNumber)
    {
        DBCollection col = null;
        DBObject form = null;
        DBCursor cursor = null;
        BasicDBObject query, newDoc, update = null;
        
        if(client == null)
        {
            System.out.println("Connection not established.");
            return;
        }
        
        col = client.getDB("forms").getCollection(url);
        BasicDBObject sub = new BasicDBObject();
        
        sub.put("number", submissionNumber);
        sub.put("json", json);
        col.insert(sub);
        /*
        query = new BasicDBObject();
        query.put("unique_url", url);
        cursor = col.find(query);
        
        while(cursor.hasNext())
        {
            DBObject cursorResult = cursor.next();
                System.out.println("found correct cursor result of formName: " + formName);
                System.out.println(cursorResult);
                form = new BasicDBObject();
                form.put("sub_json", json);

                query = new BasicDBObject();
                query.put("unique_url", url);

                newDoc = new BasicDBObject();
                newDoc.put("submission_" + submissionNumber, form);

                update = new BasicDBObject();
                update.put("$set", newDoc);

                //form = col.findOne(formName);
                //obj = new BasicDBObject();

        //        obj.put(url, json);
        //        form.put("sub1", obj);
        //        col.insert(obj);

                col.update(query, update);
            }*/
        
        
        
    }
    
    public void deleteForm(String url)
    {
        DBCollection col = null;
        DBObject query = null;
        DBCursor cursor = null;
        
        if(client == null)
        {
            System.out.println("Connection not established.");
            return;
        }
        
        col = client.getDB("forms").getCollection(url);
        col.drop();
        col = client.getDB("forms").getCollection("published_forms");
        
        query = new BasicDBObject();
        query.put("unique_url", url);
        cursor = col.find(query);
        
        while(cursor.hasNext())
        {
            DBObject result = cursor.next();
            col.remove(result);
        }
    }
    
    public void deleteSubmission(String url, int submissionNumber)
    {
        BasicDBObject obj = null;
        DBCollection col = null;
        
        if(client == null)
        {
            System.out.println("Connection not established.");
            return;
        }
        
        col = client.getDB("forms").getCollection(url);
        obj = new BasicDBObject();
        
        obj.put("number", submissionNumber);
        col.remove(obj);
    }
    
    public MongoClient getClient()
    {
        return client;
    }
    
    /*public static void main(String[] args) {
        MongoClient mongoClient = null;
        DBCollection col;
        BasicDBObject obj;
        
        try {
            //mongoClient = new MongoClient( /*"192.168.137.1"// "localhost", 27017 );
            
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
            col.insert(obj);
            System.out.println("Success : )");
            
            close();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }*/
}