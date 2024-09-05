--Paris 2024 Olympics Vs Tokyo Olympics: A Comparative Analysis.

Select *
From dbo.MedalTableParis;

Select *
From dbo.MedalTokyo;

Select *
From dbo.AthletesParis;

Select *
From dbo.AthletesTokyo;

Select *
From dbo.MedallistParis;

Select *
From dbo.MedalsParis;



--Let's Clean up the data and make it ready to use.

With MedalTableParisCTE As
(Select *,ROW_NUMBER() over(Partition by Rank order by Rank) As RowNumber
From MedalTableParis)
Delete From MedalTableParisCTE
Where RowNumber > 1;

With MedalTokyoCTE As
(Select *,ROW_NUMBER() over(Partition by Rank order by Rank) As RowNumber
From dbo.MedalTokyo)
Delete From MedalTokyoCTE
Where RowNumber > 1;

Sp_rename 'TokyoMedal.Team/NOC','country';


--Let's join the medal table of Paris Olympics and Tokyo Olympics.

Select *
From dbo.MedalTableParis Par
INNER JOIN dbo.MedalTokyo Tok
ON Par.Rank = Tok.Rank

--Let's Know the Top 5 Medallist(country) at both the Paris Olymics and Tokyo Olympics.

Select Top(5)*
From dbo.MedalTableParis Par
Join dbo.MedalTokyo Tok
ON Par.Rank = Tok.Rank

-- Athletes per Medal for each country.

Select name,gender,discipline,Country,count(medal_code) As [Medals Won]
From dbo.MedallistParis
Where medal_code > 1 OR medal_code > 2 AND medal_code > 3
GROUP BY name,gender,discipline,country
Order By [Medals Won] DESC


-- Country Medal count per discipline.

--Team United States
Select gender,country,discipline,count(distinct name) As TotalMedal
From dbo.MedallistParis
Where country like '%States%'
Group by gender,country,discipline
Order by TotalMedal desc;

-- Team China
Select gender,country,discipline,count(distinct name) As TotalMedal
From dbo.MedallistParis
Where country like '%china%'
Group by gender,country,discipline
Order by TotalMedal desc;

-- Team Japan
Select gender,country,discipline,count(distinct name) As TotalMedal
From dbo.MedallistParis
Where country like 'Japan%'
Group by gender,country,discipline
Order by TotalMedal desc;

-- Team Great Britain
Select gender,country,discipline,count(distinct name) As TotalMedal
From dbo.MedallistParis
Where country like 'Great Britain%'
Group by gender,country,discipline
Order by TotalMedal desc;

-- Team France
Select gender,country,discipline,count(distinct name) as TotalMedal
From dbo.MedallistParis
Where country like 'France%'
Group by gender,country,discipline
Order by TotalMedal desc;



-- Based on Gender, Let's Know Who Won More Medals Per Country.

Select gender,count(distinct discipline) As Total_gender
From dbo.MedallistParis
Where country like '%States%'
Group by gender

Select gender,count(distinct discipline) As Total_gender
From dbo.MedallistParis
Where country like 'China%'
Group by gender

Select gender,count(distinct discipline) As Total_gender
From dbo.MedallistParis
Where country like 'Japan%'
Group by gender

Select gender,count(distinct discipline) As Total_gender
From dbo.MedallistParis
Where country like 'Great Britain%'
Group by gender

Select gender,count(distinct discipline) As Total_gender
From dbo.MedallistParis
Where country like 'France%'
Group by gender


-- Let's Know Athletes that participated/didn't participate at the Paris and Tokyo Olympics.


Select *
From dbo.AthletesParis par
FULL OUTER JOIN dbo.AthletesTokyo tok
ON par.name = tok.Name


-- Let's Do A Comparative Analysis Between The Top 10 Paris Olympics And Tokyo Olympics Medal Leaderboard.

Select *
From dbo.MedalTableParis Par
Join dbo.MedalTokyo Tok
ON Par.Rank = Tok.Rank


Select par.country,par.Total,tok.Country,tok.Total,par.Rank
From dbo.MedalTableParis par
Join dbo.MedalTokyo tok 
On par.Rank = tok.Rank
Where par.Total > 30 OR tok.Country = 'Germany' 

