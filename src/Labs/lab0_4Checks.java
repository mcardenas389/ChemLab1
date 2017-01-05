package Labs;

public class lab0_4Checks extends inputChecks
{
    public lab0_4Checks(String tableName, int x, int y, 
			String userid, String courseid, int labNumber)
    {
    	super(tableName, x, y, userid, courseid, labNumber);
    }
    
    @Override
    protected void buildKey()
    {
        key = new String[][] {
        	{"clear", "light", "ionic"},
        	{"clear", "no light", "covalent"},
        	{"blue", "light", "ionic"},
        	{"blue", "dim light", "ionic"}
        };
    }
    
    public void gradeLab(int labNumber, String userid, String courseid)
    {
    	double gradeTotal = 0.0; //stores total grade
		double score = 1.0; //score for correct answer
		
    	buildKey();
    	
    	for(int i = 0; i < dataX; i++)
    	{
    		for(int j = 0; j < dataY; j++)
    		{
    			if(key[i][j].equalsIgnoreCase(data[i][j]))
    			{
    				isCorrect[i][j] = correctMsg;
					grade[i][j] = "" + score;
					gradeTotal += score;
    			}
    			else
    			{
    				isCorrect[i][j] = errorMsg;
					grade[i][j] = "-" + score; //deducted points
					error[i][j] = errorTypes[3]; //generic error  
    			}
    		}
    	}
    	
    	//submit(labNumber, userid, courseid, gradeTotal);
    }
}
