var Choix =
{
	liste: undefined,
	num2code: {},
	courant: -1,
	brancher: function()
	{
		Choix.liste = document.querySelector('#choix ul');
		Choix.liste.addEventListener('click', Choix.clic);
		document.body.addEventListener('keydown', Choix.touche);
		
		var i, l = Choix.liste.children;
		for(i = -1; ++i < l.length;)
			Choix.num2code[l[i].dataset.code] = i;
	},
	clic: function(ev)
	{
		for(var e = ev.target; e.nodeName != 'UL'; e = e.parent)
			if(e.dataset && e.dataset.code)
			{
				Choix.courir(e);
				Choix.courir(Choix.courant);
				// Pas de preventDefault: si on clique la case à cocher, ou si on veut sélectionner le titre, on laisse faire.
				break;
			}
	},
	courir: function(e)
	{
		var num;
		if(typeof e == 'number')
			e = Choix.liste.children[num = e];
		else
			num = Choix.num2code[e.dataset.code];
		
		if(num == Choix.courant) return;
		if(num < 0 || num >= Choix.liste.children.length) return;
		
		var ancien = Choix.liste.children[Choix.courant];
		if(ancien)
			ancien.classList.remove('courant');
		Choix.courant = num;
		e.classList.add('courant');
		e.scrollIntoView({ block: 'center', container: 'nearest' }); // À FAIRE: Edge ne l'a supporté que très tard.
	},
	touche: function(ev)
	{
		switch(ev.key)
		{
			case 'ArrowDown':
			case 'ArrowUp':
				Choix.courir(Choix.courant + (ev.key == 'ArrowDown' ? 1 : -1));
				ev.preventDefault(true);
				ev.stopPropagation();
				break;
		}
	}
};
