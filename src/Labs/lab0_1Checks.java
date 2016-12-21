package Labs;

public class lab0_1Checks extends inputChecks
{
	public lab0_1Checks(String tableName, int x, int y, 
			String userid, String courseid, int labNumber)
	{
        super(tableName, x, y, userid, courseid, labNumber);
    }
 
	@Override
    protected void buildKey()
    {
		int k = 0; //holds integer values for each answer
		
        for(int i = 0; i < dataX; ++i)
        {
            for (int j = 0; j < dataY; ++j)
            {
                if(data[i][j] != null)
                {
                    key[i][j] = "*"; //initialized as '*'
                    
                    //Quadruple beam balance (sig figs)
                    if (i > 1 && i < 4)
                    {
                    	if(j == 0)
                    	{
                    		key[i][j] = setDecPlaces(data[i][j], 3);
                    	}
                    	else if(j == 2)
                    	{
                    		k = getSigFigs(data[i][0]);
                    		key[i][j] = Integer.toString(k);
                    	}
                    }
                    
                    //Analytical balance (sig figs)
                    if(i > 3 && i < 10)
                    {
                        if(j == 0) 
                    	{
                    		key[i][j] = setDecPlaces(data[i][j], 4);
                    	}
                    	else if(j == 2)
                    	{
                    		k = getSigFigs(data[i][0]);
                    		key[i][j] = Integer.toString(k);
                    	}
                    }
                    
                    //Number of Sig Fig Column for the calculated data
                    if ((i > 9 && i < dataX) && j == 2)
                    {
                    	key[i][j] = "" + getSigFigs(data[i][0]);
                    }
                    
                    //Unit column
                    if((i > 1 && i < dataX) && j == 1)
                    {
                    	key[i][j] = "g";
                    }
                    
                    //average weight of metal wire
                    if(i == 10 && j == 0)
                    {
                    	Double temp = 0.0;
                        temp = Double.parseDouble(key[5][0]) +
                                Double.parseDouble(key[6][0]) +
                                Double.parseDouble(key[7][0]);
                        temp = temp / 3;
                        String temp1 = setDecPlaces(Double.toString(temp), 4);              	
                        
                        key[i][j] = "" + temp1;
                    }
                    
                    //weight of sodium chloride
                    if(i == 11 && j == 0)
                    {
                    	Double temp = 0.0;
                        temp = Double.parseDouble(key[8][0]) - 
                                Double.parseDouble(key[9][0]);
                        String temp1 = setDecPlaces(Double.toString(temp), 4);
                        
                        key[i][j] = "" + temp1;
                    }
                }
                else
                {
                    //setKey(i,j,"WRONG");
                }
                
                //for testing only!
                //setError(i,j,getError(i,j) + " <*> " + getKey(i,j));
            }
        }
    }
	
	public void gradeLab(int labNumber, String userid, String courseid)
	{
		double gradeTotal = 0.0; //stores total grade
		double sigFigScore = 2.5; //score for correct significant figure
		double unitScore = 1.0; //score for correct unit
		double calcScore = 4.0; //score for correct calculation
		
		buildKey();
		
		//check input for quadruple and analytical balance 
		for(int i = 2; i < 10; ++i)
		{
			//check significant figures of weighed values
			if((getDecPlaces(data[i][0]) == getDecPlaces(key[i][0]) ||
					(getDecPlaces(data[i][0]) == getDecPlaces(key[i][0]) - 1 && key[i][0].charAt(key[i][0].length() - 1) == '0')))
			{
				isCorrect[i][0] = correctMsg;	
				grade[i][0] = "" + sigFigScore;
				gradeTotal += sigFigScore;
			}
			else
			{
				isCorrect[i][0] = errorMsg;
				grade[i][0] = "-" + sigFigScore; //deducted points
				error[i][0] = errorTypes[0]; //sig fig error				
			}
			
			//check user input of significant figures
			if(Integer.parseInt(data[i][2]) == Integer.parseInt(key[i][2]))
			{
				isCorrect[i][2] = correctMsg;	
				grade[i][2] = "" + sigFigScore;
				gradeTotal += sigFigScore;
			}
			else
			{
				isCorrect[i][2] = errorMsg;
				grade[i][2] = "-" + sigFigScore; //deducted points
				error[i][2] = errorTypes[0]; //sig fig error				
			}
		}
		
		//check significant figures and calculation of average metal weight
		if(getSigFigs(data[10][0]) == getSigFigs(key[10][0]) && Double.parseDouble(data[10][0]) == Double.parseDouble(key[10][0]))
		{
			isCorrect[10][0] = correctMsg;
			grade[10][0] = "" + sigFigScore + ", " + calcScore;
			gradeTotal += sigFigScore + calcScore;
		}
		else if(getSigFigs(data[10][0]) != getSigFigs(key[10][0]) && Double.parseDouble(data[10][0]) != Double.parseDouble(key[10][0]))
		{
			isCorrect[10][0] = errorMsg;
			grade[10][0] = "-" + sigFigScore + ", -" + calcScore; //deducted points
			error[10][0] = errorTypes[0] + ", " + errorTypes[1]; //sig fig error and calculation error
		}
		else
		{
			isCorrect[10][0] = errorMsg;
			
			if(getSigFigs(data[10][0]) != getSigFigs(key[10][0]))
			{
				grade[10][0] = "-" + sigFigScore; //deducted points
				error[10][0] = errorTypes[0]; //sig fig error
				gradeTotal += calcScore;
			}			
			else if(Double.parseDouble(data[10][0]) != Double.parseDouble(key[10][0]))
			{
				grade[10][0] += "-" + calcScore; //deducted points
				error[10][0] += errorTypes[1]; //calculation error
				gradeTotal += sigFigScore;
			}
		}

		//check significant figure field of average metal weight
		if(Integer.parseInt(data[10][2]) == Integer.parseInt(key[10][2]))
		{
			isCorrect[10][2] = correctMsg;
			grade[10][2] = "" + sigFigScore;
			gradeTotal += sigFigScore;
		}
		else
		{
			isCorrect[10][2] = errorMsg;
			grade[10][2] = "-" + sigFigScore; //deducted points
			error[10][2] = errorTypes[0]; //sig fig error
		}
		
		//check significant figure and calculation of sodium chloride weight
		if(getSigFigs(data[11][0]) == getSigFigs(key[11][0]) && Double.parseDouble(data[11][0]) == Double.parseDouble(key[11][0]))
		{
			isCorrect[11][0] = correctMsg;
			grade[11][0] = "" + sigFigScore + ", " + calcScore;
			gradeTotal += sigFigScore + calcScore;
		}
		else if(getSigFigs(data[11][0]) != getSigFigs(key[11][0]) && Double.parseDouble(data[11][0]) != Double.parseDouble(key[11][0]))
		{
			isCorrect[11][0] = errorMsg;
			grade[11][0] = "-" + sigFigScore + ", -" + calcScore; //deducted points
			error[11][0] = errorTypes[0] + ", " + errorTypes[1]; //sig fig error and calculation error
		}
		else
		{
			isCorrect[11][0] = errorMsg;
			
			if(getSigFigs(data[11][0]) != getSigFigs(key[10][0]))
			{
				grade[11][0] = "-" + sigFigScore; //deducted points
				error[11][0] = errorTypes[0]; //sig fig error
				gradeTotal += calcScore;
			}			
			else if(Double.parseDouble(data[11][0]) != Double.parseDouble(key[11][0]))
			{
				grade[11][0] = "-" + calcScore; //deducted points
				error[11][0] = errorTypes[1]; //calculation error
				gradeTotal += sigFigScore;
			}
		}
		
		//check significant figure field of sodium chloride weight
		if(Integer.parseInt(data[11][2]) == Integer.parseInt(key[11][2]))
		{
			isCorrect[11][2] = correctMsg;
			grade[11][2] = "" + sigFigScore;
			gradeTotal += sigFigScore;
		}
		else
		{
			isCorrect[11][2] = errorMsg;
			grade[11][2] = "-" + sigFigScore; //deducted points
			error[11][2] = errorTypes[0]; //sig fig error
		}
		
		//check units
		for(int i = 2; i < dataX; ++i)
		{
			if(data[i][1].charAt(0) == key[i][1].charAt(0))
			{
				isCorrect[i][1] = correctMsg;
				grade[i][1] = "" + unitScore;
				gradeTotal += unitScore;
			}
			else
			{
				isCorrect[i][1] = errorMsg;
				grade[i][1] = "-" + unitScore; //deducted points
				error[i][1] = errorTypes[2]; //unit error
			}
		}
		
		//submit(labNumber, userid, courseid, gradeTotal);
	}
}
