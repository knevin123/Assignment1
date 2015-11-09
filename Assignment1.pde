void setup()
{
  size(500,500);
  String[] lines = loadStrings("goals.txt"); // Load each line into a String array
  ArrayList<Float> goalData = new ArrayList<Float>(); // Create an arraylist
  for(String s:lines)
  {
    // Add each element from the string array to the arrraylist
    float f = Float.parseFloat(s);
    goalData.add(f);
  } 
  barwidth=(float)width/goalData.size();
  float x=0;
  float highest = goalData.get(0);
  int highestIndex = 0;
  for (int i = 1 ; i < goalData.size() ; i ++)
  {
    if (goalData.get(i) > highest)
    {
      highest = goalData.get(i);
      highestIndex = i;
    }
  }
  for(int i=0;i<goalData.size();i++) 
  {
    barheight=-((goalData.get(i)-500) * ((height-50)/(highest-400)));
    fill(random(50,255),random(50,175),0);
    rect(x,height,barwidth,barheight);
    x+=barwidth;
    println(goalData.get(i));
  }
}
float barwidth;
float barheight;
float avheight;
void draw()
{
  
  
}
