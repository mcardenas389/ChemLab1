package Labs;

import blackboard.platform.context.Context;

 
public class lab0_2Checks extends inputChecks
{
	public lab0_2Checks(Context ctx, String tableName, int x, int y, 
			String userid, String courseid, int labNumber)
	{
        super(ctx, tableName, x, y, userid, courseid, labNumber);
    }
	 
    @Override
    protected void buildKey()
    {
    	int k = 15; //used as iterator for calculating volume and weight of liquid in beaker
    	
        for(int i = 0; i < dataX; i ++)
        {
            for(int j = 0; j < dataY; j++)
            {
                if(data[i][j] != null && !data[i][j].equals(""))
                {
                    key[i][j] = "*";
                    
                    if(j == 0) //measurements
                    {
	                    if (i == 1) //weight of unknown metal	                    
	                    {
	                        key[i][j] = setDecPlaces(data[i][j], 4);
	                    }
	
	                    if (i > 1 && i < 4) //graduate cylinder readings
	                    {
	                    	key[i][j] = setDecPlaces(data[i][j], 1);
	                    }
	
	                    if (i > 4 && i < 10) //buret readings
	                    {
	                    	key[i][j] = setDecPlaces(data[i][j], 2);
	                    }
	                    
	                    if (i > 9 && i < 15) //weight of beaker
	                    {
	                    	key[i][j] = setDecPlaces(data[i][j], 4);
	                    }
	
	                    if (i == 15) //volume of metal
	                    {
	                        double temp = Double.parseDouble(key[3][0]) -
	                                Double.parseDouble(key[2][0]);
	                        key[i][j] = setDecPlaces("" + temp, 1);
	                    }
	
	                    if (i == 16) //density of metal
	                    {
	                        double temp = Double.parseDouble(key[1][0]) /
	                                Double.parseDouble(key[15][0]);
	                        
	                        key[i][j] = setDecPlaces("" + temp, 2);
	                    }
	
	                    if (i > 16 && i < 21) //total volume of liquid in beaker
	                    {
	                    	double temp;
	                    	
	                    	temp = Double.parseDouble(key[k++][j]) -
	                    			Double.parseDouble(key[5][j]);
	                    		
	                    	key[i][j] = setDecPlaces("" + temp, 2);	                    	
	                    }
	                    
	                    if (i > 20 && i < 25) //total weight of liquid in beaker
	                    {
	                    	double temp;
	                    	
	                    	temp = Double.parseDouble(key[k++][j]) -
	                    			Double.parseDouble(key[10][j]);
	                        
	                    	key[i][j] = setDecPlaces("" + temp, 4);
	                    }
	
	                    if (i == 25) //density of unknown liquid
	                    {
	                    	key[i][j] = setSigFigs(data[i][j], 3);
	                    }
                    }
                    else if(j == 1) //units
                    {
                    	if(i == 1 || (i > 9 && i < 14) || (i > 20 && i < 25))
                    	{
                    		key[i][j] = "g";
                    	}                    	
                    	else if((i > 4 && i < 10) || (i > 16 && i < 21))
                    	{
                    		key[i][j] = "mL";
                    	}                    	
                    	else if(i == 15)
                    	{
                    		key[i][j] = "mL,cm3";
                    	}
                    	else if(i == 16)
                    	{
                    		key[i][j] = "g/mL,g/cm3";
                    	}
                    	else if(i == 25)
                    	{
                    		key[i][j] = "g/mL";
                    	}
                    }
                }
            }
        }
    }
    
    public void gradeLab(int labNumber, String userid, String courseid)
    {
    	double gradeTotal = 0.0; //stores total grade
		double sigFigScore = 1.0; //score for correct significant figure
		double unitScore = 1.0; //score for correct unit
		double calcScore = 1.0; //score for correct calculation
		
    	for(int i = 0; i < dataX; i++)
    	{
    		for(int j = 0; j < dataY; j++)
    		{
    			if(j == 0)
    			{
    				if((i > 0 && i < 4) || (i > 4 && i < dataX))
    				{
    					if(data[i][j] == key[i][j])
        				{
        					isCorrect[i][j] = correctMsg;
        					grade[i][j] = "" + sigFigScore;
        					gradeTotal += sigFigScore;
        				}
        				else
        				{
        					isCorrect[i][j] = errorMsg;
        					grade[i][j] = "-" + sigFigScore; //deducted points
        					error[i][j] = errorTypes[0]; //significant figure error    					
        				}
    					
    					if(i > 14 && i < 25)
    					{
    						if(Double.parseDouble(data[i][j]) == Double.parseDouble(key[i][j]))
    						{
            					isCorrect[i][j] = correctMsg;
            					grade[i][j] = "" + calcScore;
            					gradeTotal += calcScore;
            				}
            				else
            				{
            					isCorrect[i][j] = errorMsg;
            					grade[i][j] = ",-" + calcScore; //deducted points
            					error[i][j] = "," + errorTypes[1]; //significant figure error    					
            				}
    					}
    				}
    			}
    			else if(j == 1)
    			{
    				if(data[i][j] == key[i][j])
    				{
    					isCorrect[i][j] = correctMsg;
    					grade[i][j] = "" + unitScore;
    					gradeTotal += unitScore;
    				}
    				else if(i == 15 || i == 16)
    				{
    					String[] choices = key[i][j].split(",");
    					
    					if(data[i][j] == choices[0] || data[i][j] == choices[1])
    					{
    						isCorrect[i][j] = correctMsg;
        					grade[i][j] = "" + unitScore;
        					gradeTotal += unitScore;
    					}
    					else
    					{
    						isCorrect[i][j] = errorMsg;
        					grade[i][j] = "-" + unitScore; //deducted points
        					error[i][j] = errorTypes[2]; //unit error 
    					}
    				}
    				else
    				{
    					isCorrect[i][j] = errorMsg;
    					grade[i][j] = "-" + unitScore; //deducted points
    					error[i][j] = errorTypes[2]; //unit error    					
    				}
    			}
    		}
    	}
    	
    	submit(labNumber, userid, courseid, gradeTotal);
    }
}
