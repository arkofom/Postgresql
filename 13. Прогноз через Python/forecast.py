import matplotlib.pyplot as plt
import pandas as pd
from sqlalchemy import create_engine


base = ''
name_pass = ''
pref = ''
engine = create_engine(f"{pref}://{name_pass}@{base}")
def exp_average(dateFrom: str, dateTo: str, alpha: float=0.1) -> pd.DataFrame:
    SQL = '''
        SELECT recept.storage                                                      st,
                   recgoods.goods                                                      g,
                   recept.ddate                                                        d,
                   sum(recgoods.volume * goods.length * goods.height * goods.width) AS vol
            FROM recept
                     JOIN recgoods ON recept.id = recgoods.id
                     JOIN goods ON recgoods.goods = goods.id
            WHERE recept.ddate >=  %(mindate)s
              AND recept.ddate <= %(maxdate)s
            GROUP BY recept.storage, recgoods.goods, recept.ddate
            ORDER BY recept.storage, recgoods.goods, recept.ddate
    '''

    df = pd.read_sql(
        SQL,
        engine,
        params={'mindate': dateFrom, 'maxdate': dateTo},
        parse_dates={'recept.ddate': dict(format='%Y%m%d')}
    )

    dfs = df.set_index(['st', 'g'])
    dfs.drop('d', axis=1, inplace=True)
    dfs = dfs.ewm(alpha=alpha, adjust=False).mean()
    dfs.reset_index(level=[0,1], inplace=True)
    dfs.reset_index(drop=True, inplace=True)
    names = ['storage', 'goods', 'date', 'sum']
    df.columns = names
    df['prediction'] = dfs['vol']

    return df

exp_average('20200201', '20201231', 0.1)


result = moving_average('20200201', '20201231', 2)
print(result.head(30))


result["sum"][:200].plot(figsize=(16, 4), legend=True)
result["prediction"][:200].plot(figsize=(16, 4), legend=True)
plt.legend(['Data', 'Prediction'])
plt.title('Rolling mean prediciont')
plt.show()
