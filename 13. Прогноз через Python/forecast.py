import matplotlib.pyplot as plt
import pandas as pd
from sqlalchemy import create_engine


base = ''
name_pass = ''
pref = ''
engine = create_engine(f"{pref}://{name_pass}@{base}")


def moving_average(dateFrom: str, dateTo: str, window_size: int) -> pd.DataFrame:
    SQL = '''
        SELECT recept.storage st,
               recgoods.goods g,
               recept.ddate   d,
               sum(recgoods.volume * goods.length * goods.height * goods.width) AS vol
        FROM recept
                 JOIN recgoods ON recept.id = recgoods.id
                 JOIN goods ON recgoods.goods = goods.id
        WHERE recept.ddate >= %(mindate)s
          AND recept.ddate <= %(maxdate)s
        GROUP BY recept.storage,  recgoods.goods, recept.ddate;
    '''

    df = pd.read_sql(
        SQL,
        engine,
        params={'mindate': dateFrom, 'maxdate': dateTo},
        parse_dates={'recept.ddate': dict(format='%Y%m%d')}
    )

    N = df.shape[0]
    if (N < window_size):
        raise ValueError(f'Invalid windows size > {N}')

    dfs = df.set_index(['st', 'g'])
    dfs.drop('d', axis=1, inplace=True)
    dfs['vol'] = dfs['vol'].shift(1)
    dfs = dfs.groupby(level=['st', 'g']).rolling(window=window_size).mean()
    dfs.reset_index(level=[2,1], inplace=True)
    dfs.reset_index(drop=True, inplace=True)
    dft = df.sort_values(['st' ,'g'],)
    dft.reset_index(drop=True, inplace=True)
    names = ['warehouse', 'goods', 'date', 'volume']
    dft.columns = names
    dft['prediction'] = dfs['vol']
    return dft


result = moving_average('20200201', '20201231', 2)
print(result.head(30))


result["sum"][:200].plot(figsize=(16, 4), legend=True)
result["prediction"][:200].plot(figsize=(16, 4), legend=True)
plt.legend(['Data', 'Prediction'])
plt.title('Rolling mean prediciont')
plt.show()
