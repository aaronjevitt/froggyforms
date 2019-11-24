package mongo;

import com.mongodb.MongoClient;
import com.mongodb.DBCollection;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import com.mongodb.DBCursor;

public class DatabaseController {
    
    private MongoClient client = null;
    private final String ip = "localhost";
    
    /**
     * Connects to a MongoDB server at the given address.
     */
    public void connect()
    {
        try
        {
            client = new MongoClient(ip, 27017);
            
            if(client != null)
            {
                System.out.printf("Connected to %s\n", ip);
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }
    
    /**
     * Closes the connection with the MongoDB server if one was opened.
     */
    public void close()
    {
        if(client == null)
        {
            System.out.println("Connection not established before calling close().");
            return;
        }
        
        client.close();
        client = null;
    }
    
    /**
     * Adds a new form entry to the "published_forms" collection and creates
     * a new collection to hold the submissions for the new  form.
     * 
     * @param url   the unique URL associated with this form
     * @param json  the entirety of the JSON code representing the layout of the form
     */
    public void addNewForm(String url, String json)
    {
        DBCollection col = null;
        BasicDBObject obj = null;
        
        if(client == null)
        {
            System.out.println("Connection not established before trying to publish form.");
            return;
        }
        
        col = client.getDB("forms").getCollection("published_forms");
        obj = new BasicDBObject();
        
        obj.put("unique_url", url);
        obj.put("form_json", json);
        
        System.out.println("adding form " + url);
        col.insert(obj);
    }
    
    /**
     * Adds a new submission entry to the collection mapped to by the unique URL.
     * 
     * @param url               the unique URL of the form the submission is for
     * @param json              the entirety of the JSON representing the layout 
     *                          of the form and what was put into each field
     * @param submissionNumber  the index for the new submission
     */
    public void addSubmission(String url, String json, int submissionNumber)
    {
        DBCollection col = null;
        BasicDBObject sub = null;
        
        if(client == null)
        {
            System.out.println("Connection not established before trying to add submission.");
            return;
        }
        
        col = client.getDB("forms").getCollection(url);
        sub = new BasicDBObject();
        
        sub.put("number", submissionNumber);
        sub.put("json", json);
        col.insert(sub);
    }
    
    /**
     * Get the last form in the database. This *should* be the most recent form created.
     * 
     * @return the unique URL of the last form in the database
     */
    public String getLastForm()
    {
        DBCollection col = null;
        BasicDBObject form = null;
        DBCursor cursor = null;
        String url = null;
        
        if(client == null)
        {
            System.out.println("Connecrtion not established before trying to get last form.");
            return null;
        }
        
        col = client.getDB("forms").getCollection("published_forms");
        cursor = col.find();
        
        while(cursor.hasNext())
        {
            form = (BasicDBObject)cursor.next();
            url = form.getString("unique_url");
        }
        
        return url;
    }
    
    public String getFormJson(String url)
    {
        DBCollection col = null;
        DBObject query = null;
        DBCursor cursor = null;
        String json = null;
        
        if(client == null)
        {
            System.out.println("Connection not established before trying to get a form.");
            return null;
        }
        
        col = client.getDB("forms").getCollection("published_forms");
        
        query = new BasicDBObject();
        query.put("unique_url", url);
        cursor = col.find(query);
        
        while(cursor.hasNext())
        {
            BasicDBObject result = (BasicDBObject)cursor.next();
            json = result.getString("form_json");
        }
        
        return json;
    }
    
    /**
     * Deletes a form and all of its submissions from the database.
     * 
     * @param url the unique URL of the form to delete
     */
    public void deleteForm(String url)
    {
        DBCollection col = null;
        DBObject query = null;
        DBCursor cursor = null;
        
        if(client == null)
        {
            System.out.println("Connection not established before trying to delete form.");
            return;
        }
        
        // Drop the collection of submissions from the database
        col = client.getDB("forms").getCollection(url);
        col.drop();
        
        // Remove the entry for the form from the "published_forms" collection
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
    
    /**
     * Delete a single entry from the collection of submissions associated
     * with the given unique URL.
     * 
     * @param url               the unique URL of the form to delete the submission from
     * @param submissionNumber  the specific submission number to delete
     */
    public void deleteSubmission(String url, int submissionNumber)
    {
        BasicDBObject obj = null;
        DBCollection col = null;
        
        if(client == null)
        {
            System.out.println("Connection not established before trying to delete submission.");
            return;
        }
        
        col = client.getDB("forms").getCollection(url);
        obj = new BasicDBObject();
        
        obj.put("number", submissionNumber);
        col.remove(obj);
    }
    
    /**
     * Count the number of submissions that the form associated with the given
     * URL currently has.
     * 
     * @param url   the unique URL of the form to count the submissions for
     * @return      the number of submissions in the form
     */
    public long countSubmissions(String url)
    {
        DBCollection col = null;
        
        if(client == null)
        {
            System.out.println("Connection not established before trying to count submissions.");
            return -1;
        }
        
        col = client.getDB("forms").getCollection(url);
        return col.count();
    }
    
    /**
     * Check if there is a form that already exists with the given URL.
     * 
     * @param url   the unique URL to check against the database
     * @return      whether that URL is already in the database or not
     */
    public boolean checkIfExists(String url)
    {
        DBCollection col = null;
        DBObject query = null;
        DBCursor cursor = null;
        
        if(client == null)
        {
            System.out.println("Connection not established before trying to check if a URL exists.");
            return false;
        }
        
        col = client.getDB("forms").getCollection("published_forms");
        
        query = new BasicDBObject();
        query.put("unique_url", url);
        cursor = col.find(query);
        
        if(cursor.count() == 0)
        {
            return false;
        }
        
        return true;
    }
    
    /**
     * Get the object for the database that this class uses.
     * 
     * @return the MongoDB MongoClient object that this class uses
     */
    public MongoClient getClient()
    {
        return client;
    }
}