class Data
{
  //fields
  String year;
  String name;
  int goals;
  int totalGoals;
  //method
  Data (String line)
  {
    //splits the lines of the text fields into the fields
    String[] fields= line.split(",");
    year=fields[0];
    name=fields[1];
    goals=Integer.parseInt(fields[2]);
    totalGoals=Integer.parseInt(fields[3]);
  }
}
