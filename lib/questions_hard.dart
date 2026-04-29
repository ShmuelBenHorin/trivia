const String kHard = r'''
[
  {"id":"h09","category":"history","d":3,"q":"Which country was the first to grant women the right to vote?","a":["USA","UK","New Zealand","Australia"],"c":2,"f":"New Zealand granted women the vote in 1893."},
  {"id":"h10","category":"history","d":3,"q":"The 'War of Jenkin's Ear' was fought between Britain and which country?","a":["France","Spain","Portugal","Netherlands"],"c":1,"f":"It began in 1739 after Spanish coast guards cut off a British captain's ear."},
  {"id":"h13","category":"history","d":3,"q":"Which pharaoh built the Great Pyramid of Giza?","a":["Ramesses II","Tutankhamun","Khufu","Akhenaten"],"c":2,"f":"Khufu's pyramid was built around 2560 BC and stands 138.5 m today."},
  {"id":"s07","category":"science","d":3,"q":"What is the powerhouse of the cell?","a":["Nucleus","Ribosome","Mitochondria","Golgi Apparatus"],"c":2,"f":"Mitochondria produce ATP through cellular respiration."},
  {"id":"s08","category":"science","d":3,"q":"Which scientist formulated the theory of general relativity?","a":["Isaac Newton","Niels Bohr","Albert Einstein","Max Planck"],"c":2,"f":"Einstein published general relativity in 1915."},
  {"id":"s11","category":"science","d":3,"q":"What is the half-life of Carbon-14?","a":["1,730 years","5,730 years","10,000 years","57,300 years"],"c":1,"f":"This makes C-14 useful for dating organic material up to ~50,000 years old."},
  {"id":"s14","category":"science","d":3,"q":"What is the Schrödinger's cat thought experiment about?","a":["Animal behaviour","Quantum superposition","Relativity","Black holes"],"c":1,"f":"It illustrates the problem of applying quantum superposition to macroscopic objects."},
  {"id":"g08","category":"geography","d":3,"q":"Lake Baikal in Russia holds what percentage of Earth's surface fresh water?","a":["10%","20%","30%","40%"],"c":1,"f":"Baikal holds 20% of all unfrozen surface fresh water and is the world's deepest lake."},
  {"id":"g11","category":"geography","d":3,"q":"Which country has the most time zones?","a":["Russia","USA","China","France"],"c":3,"f":"France has 12 time zones due to its overseas territories."},
  {"id":"a06","category":"arts","d":3,"q":"Who sculpted 'The Thinker'?","a":["Michelangelo","Bernini","Rodin","Brancusi"],"c":2,"f":"Auguste Rodin created The Thinker in 1880 as part of 'The Gates of Hell'."},
  {"id":"a09","category":"arts","d":3,"q":"What style of art is characterised by geometric shapes and multiple perspectives?","a":["Fauvism","Cubism","Expressionism","Art Nouveau"],"c":1,"f":"Cubism was pioneered by Picasso and Georges Braque around 1907–1914."},
  {"id":"sp06","category":"sports","d":3,"q":"In which year were women first allowed to compete in the modern Olympics?","a":["1896","1900","1912","1924"],"c":1,"f":"Women competed in 5 events at the 1900 Paris Games."},
  {"id":"sp09","category":"sports","d":3,"q":"Which country has won the most Rugby World Cups?","a":["England","South Africa","New Zealand","Australia"],"c":2,"f":"New Zealand (All Blacks) have won 3 times: 1987, 2011 and 2015."},
  {"id":"p08","category":"pop","d":3,"q":"Which album is the best-selling of all time?","a":["Thriller","Back in Black","The Dark Side of the Moon","Hotel California"],"c":0,"f":"Michael Jackson's Thriller has sold an estimated 66–70 million copies worldwide."},
  {"id":"p11","category":"pop","d":3,"q":"Who designed the iconic sound of Darth Vader's breathing?","a":["John Williams","George Lucas","Ben Burtt","Marcia Lucas"],"c":2,"f":"Ben Burtt created the sound by breathing through a modified Dacor scuba regulator."},
  {"id":"t06","category":"tech","d":3,"q":"In binary, what does '1010' equal in decimal?","a":["8","9","10","11"],"c":2,"f":"8+2=10. Binary: 1×8 + 0×4 + 1×2 + 0×1 = 10."},
  {"id":"t08","category":"tech","d":3,"q":"What year was the first email sent?","a":["1965","1971","1978","1983"],"c":1,"f":"Ray Tomlinson sent the first networked email in 1971, also introducing the @ symbol."},
  {"id":"t11","category":"tech","d":3,"q":"What does 'HTTP' stand for?","a":["HyperText Transfer Protocol","High Traffic Transfer Protocol","HyperText Transmission Program","Host Transfer Text Protocol"],"c":0,"f":"HTTPS adds encryption (SSL/TLS) to the standard HTTP protocol."},
  {"id":"l06","category":"literature","d":3,"q":"The epic poem 'The Odyssey' is attributed to which ancient author?","a":["Virgil","Sophocles","Homer","Plato"],"c":2,"f":"Homer's Odyssey describes the 10-year journey of Odysseus home after the Trojan War."},
  {"id":"l09","category":"literature","d":3,"q":"Which novel begins with 'Call me Ishmael'?","a":["Robinson Crusoe","Treasure Island","Moby-Dick","Lord Jim"],"c":2,"f":"Melville's Moby-Dick was published in 1851 and was a commercial failure in his lifetime."},





 {"id":"h01","category":"science","d":3,"q":"What is the second law of thermodynamics mainly about?","a":["Energy creation","Entropy increase","Gravity","Speed of light"],"c":1,"f":"It states that entropy tends to increase in an isolated system."},
  {"id":"h02","category":"history","d":3,"q":"Which treaty ended World War I?","a":["Treaty of Versailles","Treaty of Paris","Treaty of Rome","Treaty of Berlin"],"c":0,"f":"Signed in 1919."},
  {"id":"h03","category":"science","d":3,"q":"What is Schrödinger's cat a thought experiment about?","a":["Relativity","Quantum superposition","Evolution","Gravity"],"c":1,"f":"It demonstrates quantum superposition."},
  {"id":"h04","category":"geography","d":3,"q":"Which country has the most time zones?","a":["USA","Russia","China","France"],"c":3,"f":"France has the most due to overseas territories."},
  {"id":"h05","category":"tech","d":3,"q":"What does 'SQL' stand for?","a":["Structured Query Language","Simple Query List","Standard Question Language","System Query Logic"],"c":0,"f":"Used for databases."},

  {"id":"h06","category":"science","d":3,"q":"What particle mediates the electromagnetic force?","a":["Photon","Electron","Proton","Neutron"],"c":0,"f":"Photons carry electromagnetic force."},
  {"id":"h07","category":"history","d":3,"q":"Who was the leader of the Soviet Union during WWII?","a":["Lenin","Stalin","Trotsky","Gorbachev"],"c":1,"f":"Joseph Stalin."},
  {"id":"h08","category":"science","d":3,"q":"What is Heisenberg's Uncertainty Principle about?","a":["Energy loss","Position and momentum cannot both be known precisely","Gravity waves","Speed limit"],"c":1,"f":"It limits precision of position & momentum."},
  {"id":"h09","category":"geography","d":3,"q":"Which is the deepest point on Earth?","a":["Mount Everest","Mariana Trench","Dead Sea","Grand Canyon"],"c":1,"f":"Mariana Trench (Challenger Deep)."},
  {"id":"h10","category":"tech","d":3,"q":"What is Big O notation used for?","a":["Measuring speed of internet","Algorithm complexity","File size","CPU temperature"],"c":1,"f":"Describes algorithm efficiency."},

  {"id":"h11","category":"science","d":3,"q":"What is the main function of mitochondria?","a":["Protein synthesis","Energy production","DNA storage","Cell division"],"c":1,"f":"Produces ATP energy."},
  {"id":"h12","category":"history","d":3,"q":"Which revolution introduced modern democracy in France?","a":["Industrial Revolution","French Revolution","American Revolution","Russian Revolution"],"c":1,"f":"French Revolution (1789)."},
  {"id":"h13","category":"science","d":3,"q":"What is dark matter mainly known for?","a":["Being visible","Having mass but not emitting light","Being liquid","Being radioactive"],"c":1,"f":"It does not emit light but has gravity."},
  {"id":"h14","category":"geography","d":3,"q":"Which desert is the largest in the world?","a":["Sahara","Arctic","Gobi","Kalahari"],"c":1,"f":"Arctic is technically largest desert."},
  {"id":"h15","category":"tech","d":3,"q":"What does 'API' stand for?","a":["Application Programming Interface","Advanced Program Internet","Auto Process Integration","Application Protocol Input"],"c":0,"f":"Used for software communication."},

  {"id":"h16","category":"science","d":3,"q":"What is a black hole defined by?","a":["High temperature","Extremely strong gravity","Light emission","Magnetic field"],"c":1,"f":"Gravity so strong even light cannot escape."},
  {"id":"h17","category":"history","d":3,"q":"Which empire was ruled by Genghis Khan?","a":["Roman","Mongol","Ottoman","Persian"],"c":1,"f":"Mongol Empire."},
  {"id":"h18","category":"science","d":3,"q":"What is fusion in physics?","a":["Splitting atoms","Joining atoms","Breaking molecules","Cooling gas"],"c":1,"f":"Fusion joins atomic nuclei."},
  {"id":"h19","category":"geography","d":3,"q":"Which country is NOT part of Scandinavia?","a":["Norway","Sweden","Finland","Denmark"],"c":2,"f":"Finland is sometimes excluded."},
  {"id":"h20","category":"tech","d":3,"q":"What is machine learning?","a":["Manual coding only","Systems learning from data","Hardware design","Internet protocol"],"c":1,"f":"AI learns patterns from data."},

  {"id":"h21","category":"science","d":3,"q":"What is relativity theory mainly about?","a":["Atoms","Space and time","Electricity","Chemistry"],"c":1,"f":"Einstein's theory of space-time."},
  {"id":"h22","category":"history","d":3,"q":"Which city was destroyed by Mount Vesuvius eruption?","a":["Athens","Pompeii","Rome","Alexandria"],"c":1,"f":"Pompeii in 79 AD."},
  {"id":"h23","category":"science","d":3,"q":"What is pH scale used for?","a":["Temperature","Acidity/alkalinity","Speed","Weight"],"c":1,"f":"Measures acidity."},
  {"id":"h24","category":"geography","d":3,"q":"Which river flows through multiple European capitals?","a":["Danube","Amazon","Nile","Ganges"],"c":0,"f":"Danube River."},
  {"id":"h25","category":"tech","d":3,"q":"What is blockchain mainly used for?","a":["Video editing","Decentralized records","Gaming only","Email sending"],"c":1,"f":"Distributed ledger technology."},

  {"id":"h26","category":"science","d":3,"q":"What is quantum entanglement?","a":["Chemical bonding","Particles linked instantly across distance","Gravity effect","Heat transfer"],"c":1,"f":"Quantum states become linked."},
  {"id":"h27","category":"history","d":3,"q":"Which event triggered WWI?","a":["Pearl Harbor","Assassination of Archduke Ferdinand","Fall of Berlin Wall","French Revolution"],"c":1,"f":"Archduke Ferdinand assassination."},
  {"id":"h28","category":"science","d":3,"q":"What is natural selection?","a":["Random mutation only","Survival of best adapted","Chemical reaction","Planet formation"],"c":1,"f":"Darwin's evolution theory."},
  {"id":"h29","category":"geography","d":3,"q":"Which country has the Andes mountains?","a":["Brazil","Argentina","Chile","All of the above"],"c":3,"f":"Andes span multiple countries."},




 {"id":"h31","category":"science","d":3,"q":"What is Hawking radiation associated with?","a":["Neutron stars","Black holes","Supernovas","Planets"],"c":1,"f":"Theoretical radiation emitted by black holes."},
  {"id":"h32","category":"history","d":3,"q":"Which empire split into Eastern and Western parts?","a":["Roman Empire","Mongol Empire","Ottoman Empire","British Empire"],"c":0,"f":"The Roman Empire split in 395 AD."},
  {"id":"h33","category":"science","d":3,"q":"What is the main component of the Sun?","a":["Helium","Hydrogen","Oxygen","Carbon"],"c":1,"f":"Mostly hydrogen."},
  {"id":"h34","category":"geography","d":3,"q":"Which country has the most natural lakes?","a":["USA","Canada","Russia","Finland"],"c":1,"f":"Canada has the most lakes."},
  {"id":"h35","category":"tech","d":3,"q":"What does 'compiler' do?","a":["Runs programs line by line","Translates code to machine language","Stores data","Deletes files"],"c":1,"f":"Converts code into machine language."},

  {"id":"h36","category":"science","d":3,"q":"What is a quark?","a":["A type of atom","A fundamental particle","A galaxy","A virus"],"c":1,"f":"Quarks are fundamental particles."},
  {"id":"h37","category":"history","d":3,"q":"Which treaty created the European Union precursor?","a":["Treaty of Versailles","Treaty of Maastricht","Treaty of Paris","Treaty of London"],"c":1,"f":"Maastricht Treaty (1992)."},
  {"id":"h38","category":"science","d":3,"q":"What is resonance in physics?","a":["Energy loss","Amplification at natural frequency","Gravity change","Mass increase"],"c":1,"f":"Oscillation at natural frequency."},
  {"id":"h39","category":"geography","d":3,"q":"Which is the largest island in the world?","a":["Greenland","Australia","Madagascar","Borneo"],"c":0,"f":"Greenland is largest island."},
  {"id":"h40","category":"tech","d":3,"q":"What is latency in networking?","a":["Data storage size","Delay in data transfer","CPU speed","Battery life"],"c":1,"f":"Network delay."},

  {"id":"h41","category":"science","d":3,"q":"What is the Pauli exclusion principle?","a":["No two identical particles can occupy same quantum state","Energy conservation law","Gravity rule","Heat transfer law"],"c":0,"f":"Quantum mechanics principle."},
  {"id":"h42","category":"history","d":3,"q":"Who was the first emperor of unified China?","a":["Confucius","Qin Shi Huang","Sun Tzu","Mao Zedong"],"c":1,"f":"Qin Shi Huang."},
  {"id":"h43","category":"science","d":3,"q":"What is the function of ribosomes?","a":["Energy production","Protein synthesis","DNA storage","Cell movement"],"c":1,"f":"Make proteins."},
  {"id":"h44","category":"geography","d":3,"q":"Which strait separates Asia and North America?","a":["Bering Strait","Gibraltar Strait","Hormuz Strait","Malacca Strait"],"c":0,"f":"Bering Strait."},
  {"id":"h45","category":"tech","d":3,"q":"What is an operating system kernel?","a":["Game engine","Core system managing hardware","Web browser","File type"],"c":1,"f":"Core of OS."},

  {"id":"h46","category":"science","d":3,"q":"What is entropy in thermodynamics?","a":["Order increase","Disorder measure","Mass increase","Energy creation"],"c":1,"f":"Measure of disorder."},
  {"id":"h47","category":"history","d":3,"q":"Which civilization invented democracy?","a":["Romans","Greeks","Egyptians","Persians"],"c":1,"f":"Ancient Greece."},
  {"id":"h48","category":"science","d":3,"q":"What is CRISPR used for?","a":["Space travel","Gene editing","Weather prediction","Energy storage"],"c":1,"f":"Gene editing tool."},
  {"id":"h49","category":"geography","d":3,"q":"Which mountain is highest above sea level?","a":["K2","Mount Everest","Kilimanjaro","Andes peak"],"c":1,"f":"Mount Everest."},
  {"id":"h50","category":"tech","d":3,"q":"What is DNS?","a":["Data Network System","Domain Name System","Digital Number Server","Dynamic Node Service"],"c":1,"f":"Translates domain names."},

  {"id":"h51","category":"science","d":3,"q":"What is a neutron star?","a":["Exploding star","Dense star remnant","Planet core","Gas cloud"],"c":1,"f":"Collapsed massive star."},
  {"id":"h52","category":"history","d":3,"q":"Which war ended with atomic bombs?","a":["WWI","WWII","Cold War","Korean War"],"c":1,"f":"World War II."},
  {"id":"h53","category":"science","d":3,"q":"What is osmosis?","a":["Movement of heat","Water movement through membrane","Light reflection","Force transfer"],"c":1,"f":"Water diffusion."},
  {"id":"h54","category":"geography","d":3,"q":"Which country has the most volcanoes?","a":["Japan","USA","Indonesia","Italy"],"c":2,"f":"Indonesia has most active volcanoes."},
  {"id":"h55","category":"tech","d":3,"q":"What is virtualization?","a":["Building hardware","Running multiple OS on one system","Deleting files","Encrypting data"],"c":1,"f":"Multiple virtual systems on one machine."},

  {"id":"h56","category":"science","d":3,"q":"What is beta decay?","a":["Atomic splitting","Neutron converting into proton","Light emission","Chemical reaction"],"c":1,"f":"Radioactive decay process."},
  {"id":"h57","category":"history","d":3,"q":"Which empire controlled the Silk Road?","a":["Roman","Mongol","British","Aztec"],"c":1,"f":"Mongol Empire."},
  {"id":"h58","category":"science","d":3,"q":"What is the Doppler effect?","a":["Color change of objects","Frequency change due to motion","Gravity shift","Mass change"],"c":1,"f":"Change in wave frequency."},
  {"id":"h59","category":"geography","d":3,"q":"Which sea has no coastline?","a":["Sargasso Sea","Black Sea","Red Sea","Mediterranean"],"c":0,"f":"Sargasso Sea."},





 {"id":"h61","category":"science","d":3,"q":"What is Planck's constant used for?","a":["Gravity calculations","Quantum energy levels","Heat transfer","Chemical bonding"],"c":1,"f":"It relates energy and frequency in quantum physics."},
  {"id":"h62","category":"history","d":3,"q":"Which event marked the start of the French Revolution?","a":["Storming of the Bastille","Fall of Rome","Battle of Waterloo","Industrial Revolution"],"c":0,"f":"Storming of the Bastille in 1789."},
  {"id":"h63","category":"science","d":3,"q":"What is the Higgs boson associated with?","a":["Mass of particles","Gravity waves","Light speed","Electric charge"],"c":0,"f":"Gives particles mass in the Standard Model."},
  {"id":"h64","category":"geography","d":3,"q":"Which country spans the most time zones (including territories)?","a":["Russia","USA","France","UK"],"c":2,"f":"France due to overseas territories."},
  {"id":"h65","category":"tech","d":3,"q":"What is a hash function used for?","a":["Image editing","Data encryption/checking integrity","Gaming","Audio processing"],"c":1,"f":"Used in cryptography and data integrity."},

  {"id":"h66","category":"science","d":3,"q":"What is a boson?","a":["Particle that carries force","Type of atom","Planet type","Cell structure"],"c":0,"f":"Force-carrying particle."},
  {"id":"h67","category":"history","d":3,"q":"Who unified Germany in 1871?","a":["Bismarck","Hitler","Napoleon","Frederick the Great"],"c":0,"f":"Otto von Bismarck."},
  {"id":"h68","category":"science","d":3,"q":"What is the main idea of general relativity?","a":["Gravity as force","Gravity as curvature of spacetime","Energy conservation","Atomic structure"],"c":1,"f":"Gravity bends spacetime."},
  {"id":"h69","category":"geography","d":3,"q":"Which country has the longest coastline?","a":["USA","Russia","Canada","Australia"],"c":2,"f":"Canada has the longest coastline."},
  {"id":"h70","category":"tech","d":3,"q":"What is a neural network inspired by?","a":["Computer chips","Human brain","Electrical grids","Mechanical systems"],"c":1,"f":"Inspired by the brain."},

  {"id":"h71","category":"science","d":3,"q":"What is radioactive half-life?","a":["Time for full decay","Time for half of atoms to decay","Energy doubling time","Speed of radiation"],"c":1,"f":"Time for half substance to decay."},
  {"id":"h72","category":"history","d":3,"q":"Which empire fell in 1453?","a":["Roman Empire","Byzantine Empire","Ottoman Empire","Persian Empire"],"c":1,"f":"Fall of Constantinople."},
  {"id":"h73","category":"science","d":3,"q":"What is wave-particle duality?","a":["Light behaves as wave and particle","Gravity waves","Sound reflection","Heat transfer"],"c":0,"f":"Quantum behavior of matter."},
  {"id":"h74","category":"geography","d":3,"q":"Which desert is in Asia and very cold?","a":["Sahara","Gobi","Kalahari","Atacama"],"c":1,"f":"Gobi Desert."},
  {"id":"h75","category":"tech","d":3,"q":"What is cloud computing?","a":["Using physical disks","Using remote servers over internet","Offline storage","Gaming hardware"],"c":1,"f":"Internet-based computing."},

  {"id":"h76","category":"science","d":3,"q":"What is antimatter?","a":["Matter with opposite charge","Dark energy","Gas type","Liquid state"],"c":0,"f":"Opposite of normal matter."},
  {"id":"h77","category":"history","d":3,"q":"Which war was fought between Athens and Sparta?","a":["Peloponnesian War","Punic War","Hundred Years War","Trojan War"],"c":0,"f":"Peloponnesian War."},
  {"id":"h78","category":"science","d":3,"q":"What is a catalyst?","a":["Slows reaction","Speeds reaction without being consumed","Creates energy","Destroys atoms"],"c":1,"f":"Speeds chemical reactions."},
  {"id":"h79","category":"geography","d":3,"q":"Which is the only continent without reptiles?","a":["Europe","Antarctica","Asia","Australia"],"c":1,"f":"Antarctica."},
  {"id":"h80","category":"tech","d":3,"q":"What does 'open source' allow?","a":["Hidden code","Public code access and modification","Only paid use","Hardware control"],"c":1,"f":"Code is publicly available."},

  {"id":"h81","category":"science","d":3,"q":"What is the uncertainty principle limit related to?","a":["Energy and time","Position and momentum","Mass and volume","Heat and light"],"c":1,"f":"Cannot precisely know both."},
  {"id":"h82","category":"history","d":3,"q":"Which civilization invented cuneiform writing?","a":["Egyptians","Sumerians","Greeks","Romans"],"c":1,"f":"Sumerians in Mesopotamia."},
  {"id":"h83","category":"science","d":3,"q":"What is escape velocity?","a":["Speed of sound","Minimum speed to escape gravity","Speed of light","Orbital speed only"],"c":1,"f":"Needed to leave a planet's gravity."},
  {"id":"h84","category":"geography","d":3,"q":"Which country has Mount Fuji?","a":["China","Japan","Korea","Thailand"],"c":1,"f":"Japan."},
  {"id":"h85","category":"tech","d":3,"q":"What is latency in systems?","a":["Storage size","Delay in response","CPU power","Screen resolution"],"c":1,"f":"Time delay in systems."},

  {"id":"h86","category":"science","d":3,"q":"What is the Standard Model in physics?","a":["Model of weather","Theory of fundamental particles","Earth model","Chemical model"],"c":1,"f":"Describes fundamental particles and forces."},
  {"id":"h87","category":"history","d":3,"q":"Which event ended the Cold War symbolically?","a":["WWII end","Fall of Berlin Wall","Moon landing","Cuban Missile Crisis"],"c":1,"f":"1989 Berlin Wall fall."},
  {"id":"h88","category":"science","d":3,"q":"What is dark energy?","a":["Energy from stars","Unknown force causing universe expansion","Heat energy","Magnetic force"],"c":1,"f":"Drives universe expansion."},
  {"id":"h89","category":"geography","d":3,"q":"Which river flows through Egypt?","a":["Amazon","Nile","Danube","Ganges"],"c":1,"f":"Nile River."},




 {"id":"h91","category":"science","d":3,"q":"What is the principle of conservation of energy?","a":["Energy can be created","Energy cannot be created or destroyed","Energy only increases","Energy disappears over time"],"c":1,"f":"Energy is conserved in isolated systems."},
  {"id":"h92","category":"history","d":3,"q":"Which treaty created modern European borders after WWII?","a":["Treaty of Versailles","Post-war agreements","Treaty of Rome","Treaty of Paris"],"c":1,"f":"Multiple agreements shaped post-WWII Europe."},
  {"id":"h93","category":"science","d":3,"q":"What is a superconductor?","a":["Material with no resistance at low temperatures","Material that burns electricity","Liquid metal","Gas conductor"],"c":0,"f":"Zero electrical resistance below critical temperature."},
  {"id":"h94","category":"geography","d":3,"q":"Which is the only country that is also a continent?","a":["USA","Australia","India","Brazil"],"c":1,"f":"Australia is both a country and continent."},
  {"id":"h95","category":"tech","d":3,"q":"What does 'cache' do in computing?","a":["Slows processing","Stores frequently used data for fast access","Deletes files","Encrypts data"],"c":1,"f":"Speeds up access to data."},

  {"id":"h96","category":"science","d":3,"q":"What is redshift in astronomy?","a":["Color of planets","Wavelength stretching due to expansion","Star temperature","Black hole color"],"c":1,"f":"Indicates universe expansion."},
  {"id":"h97","category":"history","d":3,"q":"Which empire built the Hagia Sophia originally?","a":["Roman","Byzantine","Ottoman","Greek"],"c":1,"f":"Built under Byzantine Emperor Justinian I."},
  {"id":"h98","category":"science","d":3,"q":"What is an exoplanet?","a":["Planet outside solar system","Moon of Earth","Asteroid","Star cluster"],"c":0,"f":"Planets outside our solar system."},
  {"id":"h99","category":"geography","d":3,"q":"Which country has the Amazon rainforest?","a":["Peru","Brazil","Colombia","All of the above"],"c":3,"f":"Amazon spans multiple countries."},
  {"id":"h100","category":"tech","d":3,"q":"What is encryption used for?","a":["Increasing speed","Securing data","Deleting viruses","Improving graphics"],"c":1,"f":"Protects data using algorithms."},

  {"id":"h101","category":"science","d":3,"q":"What is inertia dependent on?","a":["Color","Mass","Temperature","Speed only"],"c":1,"f":"Inertia depends on mass."},
  {"id":"h102","category":"history","d":3,"q":"Which civilization built the Hanging Gardens (if they existed)?","a":["Greek","Babylonian","Roman","Egyptian"],"c":1,"f":"Attributed to Babylon."},
  {"id":"h103","category":"science","d":3,"q":"What is the function of chlorophyll?","a":["Digest food","Absorb light for photosynthesis","Produce oxygen in lungs","Create bones"],"c":1,"f":"Absorbs sunlight."},
  {"id":"h104","category":"geography","d":3,"q":"Which country has the most active volcanoes?","a":["USA","Indonesia","Japan","Italy"],"c":1,"f":"Indonesia has the most active volcanoes."},
  {"id":"h105","category":"tech","d":3,"q":"What is an IP address?","a":["Computer name","Unique network identifier","Virus type","Screen resolution"],"c":1,"f":"Identifies devices on network."},

  {"id":"h106","category":"science","d":3,"q":"What is the Pauli exclusion principle about?","a":["No two identical fermions share same quantum state","Energy loss","Gravity rules","Light speed"],"c":0,"f":"Quantum mechanics rule."},
  {"id":"h107","category":"history","d":3,"q":"Which empire controlled Constantinople before 1453?","a":["Roman","Byzantine","Ottoman","Greek"],"c":1,"f":"Byzantine Empire."},
  {"id":"h108","category":"science","d":3,"q":"What is photosphere?","a":["Outer layer of Sun","Core of Earth","Ocean surface","Atmosphere layer of Earth"],"c":0,"f":"Visible surface of the Sun."},
  {"id":"h109","category":"geography","d":3,"q":"Which desert is the driest place on Earth?","a":["Sahara","Atacama","Gobi","Antarctic"],"c":1,"f":"Atacama Desert."},
  {"id":"h110","category":"tech","d":3,"q":"What is an API key used for?","a":["Decorating UI","Authentication to services","Speeding CPU","Deleting files"],"c":1,"f":"Used to authenticate requests."},

  {"id":"h111","category":"science","d":3,"q":"What is quantum superposition?","a":["Particles being in multiple states at once","Gravity increase","Heat transfer","Electric charge"],"c":0,"f":"Core quantum principle."},
  {"id":"h112","category":"history","d":3,"q":"Who was the first Roman emperor?","a":["Julius Caesar","Augustus","Nero","Trajan"],"c":1,"f":"Augustus."},
  {"id":"h113","category":"science","d":3,"q":"What is an isotope?","a":["Same element, different neutrons","Different element","Gas type","Energy form"],"c":0,"f":"Same protons, different neutrons."},
  {"id":"h114","category":"geography","d":3,"q":"Which river forms part of the US-Mexico border?","a":["Amazon","Rio Grande","Danube","Nile"],"c":1,"f":"Rio Grande."},
  {"id":"h115","category":"tech","d":3,"q":"What is latency affected by?","a":["Distance and processing time","Color of screen","Battery size","Keyboard type"],"c":0,"f":"Distance and processing delay."},

  {"id":"h116","category":"science","d":3,"q":"What is nuclear fission?","a":["Joining atoms","Splitting atoms","Light reflection","Heat creation"],"c":1,"f":"Splitting atomic nuclei."},
  {"id":"h117","category":"history","d":3,"q":"Which war used trench warfare heavily?","a":["WWI","WWII","Cold War","Korean War"],"c":0,"f":"World War I."},
  {"id":"h118","category":"science","d":3,"q":"What is Doppler effect used to measure?","a":["Time","Speed via wave change","Mass","Temperature"],"c":1,"f":"Wave frequency shift."},


  {"id":"l12","category":"literature","d":3,"q":"Which American poet wrote 'The Road Not Taken'?","a":["Walt Whitman","Emily Dickinson","Robert Frost","Langston Hughes"],"c":2,"f":"Frost wrote the poem in 1916 as a gentle joke for his friend Edward Thomas."}
]
''';
