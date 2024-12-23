#include <math.h>
#include <stdio.h>

typedef struct
{
    int num_roots; // Số nghiệm: 0 (không có nghiệm), 1 (nghiệm kép), 2 (hai nghiệm)
    double root1;  // Nghiệm thứ nhất
    double root2;  // Nghiệm thứ hai
} QuadraticResult;

QuadraticResult solve_quadratic(double a, double b, double c)
{
    QuadraticResult result;
    if (a == 0)
    {
        // Không phải phương trình bậc 2
        if (b == 0)
        {
            result.num_roots = 0; // Không có nghiệm
        }
        else
        {
            result.num_roots = 1;
            result.root1 = -c / b; // Nghiệm tuyến tính
        }
        return result;
    }

    double discriminant = b * b - 4 * a * c;
    if (discriminant > 0)
    {
        result.num_roots = 2;
        result.root1 = (-b + sqrt(discriminant)) / (2 * a);
        result.root2 = (-b - sqrt(discriminant)) / (2 * a);
    }
    else if (discriminant == 0)
    {
        result.num_roots = 1;
        result.root1 = -b / (2 * a);
    }
    else
    {
        result.num_roots = 0; // Vô nghiệm
    }
    return result;
}
