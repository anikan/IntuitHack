
//Given an empty image and a current image, determine how crowded Price Center is.
public class PCAnalyzer {
    private static final int lazyPersonAverage()
    private int numDifferentPixels = 0;
    private int threshold = 10;


    public void analyze (Picture reference, Picture input)
    {
        for (int i = 0; i < reference.width; i++)
        {
            for (int j = 0; j < reference.height; j++)
            {
                Pixel refPixel = reference.getPixel(i,j);
                Pixel inputPixel = input.getPixel(i,j);
                
                int redDiff = Math.abs(refPixel.red - inputPixel.red);
                int greenDiff = Math.abs(refPixel.green - inputPixel.green);
                int blueDiff = Math.abs(refPixel.blue - inputPixel.blue);
                
                if (redDiff + greenDiff + blueDiff > threshold)
                {
                    numDifferentPixels++;
                    inputPixel.setPixel(0,255,0);
                }
            }
        }
    }
}