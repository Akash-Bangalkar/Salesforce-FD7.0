public class AccountRatingSite {
	public static void setTickerSymbol(List<Account> accList)
    {
        for(Account acc:accList)
        {
            if(acc.Rating=='Hot')
            {
                acc.TickerSymbol = 'H - '+ acc.Name;
            }
            else if(acc.Rating=='Warm')
            {
                acc.TickerSymbol = 'W - '+ acc.Name;
            }
            else if(acc.Rating=='Cold')
            {
                acc.TickerSymbol = 'C - '+ acc.Name;
            }
        }
    }
}