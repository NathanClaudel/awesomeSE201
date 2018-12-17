int f(char *str)
{
    if(str == 0) return -1;
    
    char a1 = *str;

    int cpt = 0;

    while(a1 != 0)
    {
        if(a1 != 0x20) cpt++;

        str ++; 
        a1 = *str;
    }

    return cpt;
}
