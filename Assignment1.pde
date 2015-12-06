void setup()
{
  size(500,500);
  
  //calling functions to load in data 
  //and calculate the min and max values
  loadData();
  calcMinMax();
  
  //putting values into variables
  border = 0.1 * width;
  correlation=coefficient();
  choice=0;
  

}


void draw()
{
  //if statement to check which key for the menu is being pressed
  if (keyPressed)
    {
      if (key == '0')
      {
        choice = 0;
      }      
      if (key == '1')
      {
         choice = 1;
      }
      if (key == '2')
      {
        choice = 2;
      } 
      if (key == '3')
      {
        choice = 3;
      } 
    }
    
    //changes to screen depending on the key
    if (choice == 0)
      {
        menu();
      }      
      if (choice == 1)
      {
         drawBarChart();
         showName();
      }
      if (choice == 2)
      {
        drawLineGraph();
      } 
      if (choice == 3)
      {
        drawScatterPlot();
      }
  
}
//variables
float barwidth;
float barheight;
float avheight;
float border;
float correlation;
float min,max,min2,max2;
int choice;

//array list for data from text diagram
//array list is made of the Data class
ArrayList<Data> data= new ArrayList<Data>();

//mainmenu
void menu()
{
  background(0);
  stroke(255);
  textSize(20);
  fill(255);
  //writing the text for the menu 
  text("Press buttons to navigate through data",width/2,50);
  fill(0,0,255);
  textAlign(CENTER);
  text("Press 1 for Barchart",width/2,100);
  fill(255,0,0);
  textAlign(CENTER);
  text("Press 2 for line graph",width/2,150);
  fill(0,255,0);
  textAlign(CENTER);
  text("Press 3 for scatter plot",width/2,200);
}

//function to load the data in
void loadData()
{
  //reading in the text file
  String[] lines = loadStrings("GoalScorers.txt");
  //adding the data to the arraylist
  for(String line: lines)
  {
    Data goals = new Data(line);
    data.add(goals);
  }
}



void calcMinMax()
{
  min = max = data.get(0).goals; 
  for (Data goals:data)
  {
    if (goals.goals < min)
    {
      min = goals.goals;
    }
    if (goals.goals > max)
    {
      max = goals.goals;
    }    
  }
  min2 = max2 = data.get(0).totalGoals; 
  for (Data goals:data)
  {
    if (goals.totalGoals < min2)
    {
      min2 = goals.totalGoals;
    }
    if (goals.totalGoals > max2)
    {
      max2 = goals.totalGoals;
    }    
  }
  
}

void drawLineGraph()
{
  background(0);
  stroke(255);
  
  line(border - 10, height - border, width - border, height - border);
  line(border, border, border, height - border + 10);
  
  
  for (int i = 1 ; i < data.size() ; i ++)
  {
    stroke(255,0,0);
    float x1 = map(i - 1, 0, data.size() - 1, border, width - border);
    float y1 = map(data.get(i - 1).totalGoals, min2, max2, height - border, border);
    float x2 = map(i, 0, data.size() - 1, border, width - border);
    float y2 = map(data.get(i).totalGoals, min2, max2, height - border, border);
    float xtrax = map(22, 0, data.size() - 1, border, width - border);
    float xtray = map(data.get(22).totalGoals, min2, max2, height - border, border);
    line(x1, y1, x2, y2);
    ellipse(x1,y1,5,5);
    ellipse(x2,y2,5,5);
    
    //Printing data when hovering between points
    if (mouseX >= x1 && mouseX <= x2)
    {      
      stroke(0, 0, 255);
      fill(0, 0, 255);
      
      if(i<17)
      {
        textSize(12);
        textAlign(LEFT);
        text("Year: " + data.get(i - 1).year, mouseX+15, mouseY);
        text("Total Goals: " + data.get(i - 1).totalGoals, mouseX+15, mouseY+15);
      }
      else
      {
        textSize(12);
        textAlign(RIGHT);
        text("Year: " + data.get(i - 1).year, mouseX-15, mouseY);
        text("Total Goals: " + data.get(i - 1).totalGoals, mouseX-15, mouseY+15);
      }
      line(x1, border, x1, height - border);
      ellipse(x1, y1, 5, 5);
      fill(0);
      
    } 
    //Printing data when hovering after last point
    if (mouseX > xtrax)
    {      
      stroke(0, 0, 255);
      fill(0, 0, 255);
      textSize(12);
      textAlign(RIGHT);
      text("Year: " + data.get(22).year, mouseX-15, mouseY);
      text("Total Goals: " + data.get(22).totalGoals, mouseX-15, mouseY+15);
      line(xtrax, border, xtrax, height - border);
      ellipse(xtrax, xtray, 5, 5);
      fill(0);
      
    } 
    
    
  }  
}

//function to draw the bar chart 
void drawBarChart()
{
  
  background(0);
  stroke(255);
  //drawing axis
  line(border - 10, height - border, width - border, height - border);
  line(border, border, border, height - border + 10);
  //solving bar width
  barwidth=(float)(width-border)/data.size();
  float x=border;
  //drawing bars for barchart
  for(int i=0;i<data.size();i++) 
  {
    //solving bar height
    barheight=-(((data.get(i).goals))) * ((height)/(max+20));
    stroke(255);
    fill(0,0,255);      
    rect(x,height-border,barwidth,barheight);
    x+=barwidth;
  }
}

//function to draw the data for the barchart
void showName()
{
  barwidth=(float)(width-border)/data.size();
  float x=border;
  for(int i=0;i<data.size();i++) 
  {
    barheight=-(((data.get(i).goals))) * ((height)/(max+20));
    
    //checks which bar it is over and prints the data for it 
    if (mouseX >= x && mouseX <= x+barwidth && mouseY <=height-border && mouseY>=barheight)
    {      
      stroke(255,0,0);
      fill(255,0,0);
      if (mouseX<width/2)
      {
        textSize(12);
        textAlign(LEFT);
        text("Top Goalscorer: " + data.get(i).name, mouseX,mouseY-5);
        text("Goals: " + data.get(i).goals, mouseX,mouseY-15);
      }
      else
      {
        textSize(12);
        textAlign(RIGHT);
        text("Top Goalscorer: " + data.get(i).name, mouseX,mouseY-5);
        text("Goals: " + data.get(i).goals, mouseX,mouseY-15);
      }
      
    } 
  
    x+=barwidth;
  }
}

//fuction to draw the scatter plot 
void drawScatterPlot()
{
  background(0);
  stroke(255);
  //draw axis  
  line(border - 10, height - border, width - border, height - border);
  line(border, border, border, height - border + 10);
  
  //drawing points
  for (int i = 1 ; i < data.size() ; i+=3)
  {
    stroke(0,255,0);
    fill(0,255,0);
    //mapping the points x's are the data for top goalscorers
    //y's are the data for the total goals 
    float x1 = map(data.get(i - 1).goals, max, 10, width - border, border);
    float y1 = map(data.get(i - 1).totalGoals, 900, max2, height - border, border);
    float x2 = map(data.get(i).goals, max, 10, width - border, border);
    float y2 = map(data.get(i).totalGoals, 900, max2, height - border, border);
    //drawing circles 
    ellipse(x1,y1,5,5);
    ellipse(x2,y2,5,5);
    
    //checking if the mouse is over a point 
    if(((mouseX<=x1+5 && mouseX>=x1-5) && (mouseY<=y1+5 && mouseY>=y1-5)) )
    {
       
      fill(255,0,0);
      textSize(12);
      textAlign(RIGHT);
      text("Top Goalscorer goals: " + data.get(i - 1).goals, mouseX, mouseY-5);
      text("Total Goals: " + data.get(i - 1).totalGoals, mouseX, mouseY+10);
      text("year: " + data.get(i - 1).year, mouseX, mouseY+25);
      ellipse(x1,y1,5,5);
      
      
    }
    if((mouseX<=x2+5 && mouseX>=x2-5) && (mouseY<=y2+5 && mouseY>=y2-5))
    {
      fill(255,0,0);
      textSize(12);
      textAlign(RIGHT);
      text("Top Goalscorer goals: " + data.get(i).goals, mouseX, mouseY-5);
      text("Total Goals: " + data.get(i).totalGoals, mouseX, mouseY+10);
      text("year: " + data.get(i).year, mouseX, mouseY+25);
      
      ellipse(x2,y2,5,5);
    }
  }
  //printing the correlation coefficient solved in coefficient()
  fill(0,255,0);
  textSize(16);
  textAlign(LEFT);
  text("Correlation="+correlation,100,100);
}

//function to solve the correlation of the scatter plot
float coefficient()
{
  //variables
  int total1,total2,total3,total4,total5;
  total1=total2=total3=total4=total5=0;
  float mean1;
  float mean2;
  mean1=0;
  mean2=0;
  float[] meandiff1=new float[data.size()];
  float[] meandiff2=new float[data.size()];
  float[] meanmult=new float[data.size()];
  float[] meansquare1=new float[data.size()];
  float[] meansquare2=new float[data.size()];
  
  //finding totals
  for (Data goals:data)
  {
    total1+=goals.goals; //data for goalscorer goals 
  }
  for (Data goals:data)
  {
    total2+=goals.totalGoals; //data for the total goals 
  }
  //finding means
  mean1=(float)total1/data.size();//goalscorer data
  mean2=(float)total2/data.size();//total goals data
  int i=0;
  //finding the differences between the data and the means
  for (Data goals:data)
  {
    meandiff1[i]=(float)goals.goals-mean1;//finding difference between the mean and data for goalscorers
    i++;
  }
  int j=0;
  for (Data goals:data)
  {
    meandiff2[j]=(float)goals.totalGoals-mean2;//finding difference between the mean and data for total goals
    j++;
  }
  for(i=0;i<data.size();i++)
  {
    //finding the multiple of the mean differences 
    meanmult[i]= (float)meandiff1[i]*meandiff2[i];//total goals diff * top goalscorers diff
    //finding the square of the mean diff for 
    meansquare1[i]=(float)meandiff1[i]*meandiff1[i];//square of total goals diff
    meansquare2[i]=(float)meandiff2[i]*meandiff2[i];//square of top goalscorers diff
    total3+=(float)meanmult[i];//total of total goals diff * top goalscorers diff
    total4+=(float)meansquare1[i];//total of square of total goals diff
    total5+=(float)meansquare2[i];//total of square of top goalscorers diff
  }
  float bottom=0;
  bottom=(float)sqrt(total4*total5);
  float coefficient=0;
  coefficient=(float)total3/bottom;
  //returning the coefficient
  return coefficient;
  
}
