class Matrix{
  double[][] mat;
  int rows, cols;
  
  Matrix(int rows, int cols){
    if(cols != rows+1 || rows <= 0) println("Invalid augmented matrix");
    this.rows = rows;
    this.cols = cols;
    mat = new double[rows][cols];
  }
  
  void printe(){
    for(int i=0; i<rows; i++){
      for(int j=0; j<cols; j++){
        print(mat[i][j]+"   ");
      }
      print("\n");
    }
  }
  
  // returns 1 if matrix is singular
  int forwardElim(){
    for (int k=0; k<rows; k++)
    {
        // init maximum value and index for pivot
        int i_max = k;
        double v_max = mat[i_max][k];
 
        /* find greater amplitude for pivot if any */
        for (int i = k+1; i < rows; i++){
            if (Math.abs(mat[i][k]) > v_max){
                v_max = mat[i][k];
                i_max = i;
            }
        }
 
        if (mat[k][i_max] == 0)
            return 1; // Matrix is singular
 
        // Swap the greatest value row with current row
        if (i_max != k)
            swap_row(k, i_max);
 
 
        for (int i=k+1; i<rows; i++)
        {
            /* factor f to set current row kth elemnt to 0,
             * and remaining kth column to 0 */
            double f = mat[i][k]/mat[k][k];
 
            /* subtract fth multiple of corresponding kth
               row element*/
            for (int j=k+1; j<cols; j++)
                mat[i][j] -= mat[k][j]*f;
 
            /* filling lower triangular matrix with zeros*/
            mat[i][k] = 0;
        }
 
        //print();
    }
    //print();
    return 0;
  }
  
  double[] backSub(){
     double[] x = new double[rows];  // An array to store solution
 
    /* Start calculating from last equation up to the
       first */
    for (int i = rows-1; i >= 0; i--)
    {
        /* start with the RHS of the equation */
        x[i] = mat[i][rows];
 
        /* Initialize j to i+1 since matrix is upper
           triangular*/
        for (int j=i+1; j<rows; j++)
        {
            /* subtract all the lhs values
             * except the coefficient of the variable
             * whose value is being calculated */
            x[i] -= mat[i][j]*x[j];
        }
 
        /* divide the RHS by the coefficient of the
           unknown being calculated */
        x[i] = x[i]/mat[i][i];
    }
    
    double[] sol = new double[rows];
    for (int i=0; i<rows; i++)
      sol[i] = x[i];
       
    return sol;
  }
  
  void swap_row(int i, int j){
    for (int k=0; k<=rows; k++)
    {
        double temp = mat[i][k];
        mat[i][k] = mat[j][k];
        mat[j][k] = temp;
    }
  }
  
  double[] gaussianElim(){
    double[] solution;
    int isSingular = this.forwardElim();
    if(isSingular == 1){
      println("Fucked up matrix, can't solve");
      solution = new double[0];
    }
    else{
      solution = backSub();
    }
    return solution;

  }
  
  
}
