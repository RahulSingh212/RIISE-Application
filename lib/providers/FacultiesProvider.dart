// ignore_for_file: file_names, unused_import, use_build_context_synchronously, unnecessary_brace_in_string_interps, avoid_print
// import 'package:eosdart/eosdart.dart' as eos;
// import 'package:flutter/material.dart' hide Action;

import 'dart:convert';
import 'dart:io';
import 'dart:io' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riise/providers/FirebaseProvider.dart';
import 'package:riise/screens/Faculty/FacultyDetailScreen.dart';

import '../models/SpeakerInfo.dart';
import "../models/FacultyInfo.dart";

class FacultiesProvider with ChangeNotifier {
  static const dataList = [
    {
      'faculty_Name': 'A V Subramanyam',
      'faculty_EmailId': 'subramanyam@iiitd.ac.in',
      'faculty_Department': 'ECE, CSE',
      'faculty_Position': 'Associate Professor (ECE, CSE)',
      'faculty_Affiliated_Centers_And_Labs':
          'Infosys Centre for Artificial Intelligence (CAI), Visual Conception Group',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'I completed my Ph.D. at Nanyang Technological University, Singapore and undergraduate studies at Indian School of Mines University, Dhanbad, India. I work in the area of Multimedia and Vision, Image Processing and, Machine Learning. In particular, I am working on problems in fine-grained object recognition with applications to object re-identification and visual tracking, adversarial attacks, and cross modal recognition. I am a recipient of the Early Career Research Award, Department of Science and Technology. Our research group – Visual Conception Group maintains an active collaboration with leading institutes like NUS Singapore, QUT Australia, NII Japan, and UiT Norway.',
      'faculty_College':
          'PhD (2012), Nanyang Technological University, Singapore',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/subramanyam.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/subramanyam',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907437"',
      'faculty_Office_Address': 'B-604 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests': 'Multimedia and Vision,Machine Learning',
      'faculty_Teaching_Interests':
          'Statistical Machine Learning,Digital Image Processing, Digital Signal Processing, Signals and Systems, Multimedia Security'
    },
    {
      'faculty_Name': 'Aasim Khan',
      'faculty_EmailId': 'aasim@iiitd.ac.in',
      'faculty_Department': 'SSH',
      'faculty_Position': 'Assistant Professor (SSH)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          "Dr. Aasim Khan is Assistant Professor at the Department of Social Sciences and Humanities, IIIT-Delhi. Aasim is a specialist in global and area studies, with a focus on South Asia. His research interests combine his training in communication, political theory and public policy, and he is particularly interested in studying the expansion of the Internet in the global South. He was educated in Delhi (St Stephen’s College and MCRC, Jamia Millia Islamia) and London (SOAS and King's College London) and completed his PhD in Politics and Public Policy, from King's College London, in 2018. Most recently, Aasim was awarded the Fulbright-Nehru postdoctoral fellowship and he will be spending a year as a Visiting Scholar in Political Science at the Watson Institute, Brown University (beginning Fall 2022).Over the years, his research and reporting has been supported by several grants and fellowships. He received the Global Institutes Studentships and the Mazumdar Fellowship (2012-2015) at the King's India Institute. In 2014, he was awarded the Global Governance Futures fellowship by the GPPi Institute (Berlin). Aasim was a visiting faculty at IIM-Indore (2019) and appointed an Associate Researcher at the Centre de Sciences Humaines (CSH, UMIFRE n°20) in September 2021. Aasim has also raised several grants to fund his work, including the IMPRESS grant by the Indian Council for Social Science Research (ICSSR), and a Global Challenges Research Fund GCRF grant (in collaboration with the Goldsmiths, UK). As a journalist he received a mid-career fellowship to report on caste and access to healthcare by PANOS South Asia (article based on the fieldwork appeared in an anthology published Penguin/Zubaan, 2012). He was also a recipient of a research stipendship for research on urban migration and markets, by the SARAI program of CSDS, Delhi.His research and commentaries have been published in several peer-reviewed journals including Culture Unbound, Global Policy, Television and New Media, India Review and contributed to several edited volumes. These include a chapter in a volume on politics of digital infrastructure in urban India titled Diginaka (Orient Blackswan, 2020). More recently, he's developed a theory of 'data states' in the global South and has contributed a chapter on it for a volume on Transforming India (forthcoming World Scientific, 2023). Another strand of this research relates the role of digital mediation in climate action and he published on the 'Climate Strikes in Millennial India' in Communication, Culture and Critique (OUP, 2022). Aasim co-edited a special issue on digital politics in 'Millennial India' (Sage, 2019) and is currently co-editing another volume on Twitter and politics in India (forthcoming in Global Policy, 2023).Aasim has delivered more than 20 public lectures in the last few years on themes related to his research and writing. Some preeminent instances include the 'Extreme Speech' workshop held at India Habitat Centre, Delhi, public seminar at the Center for Law and Governance, JNU, and an introduction to Critical Thinking in Social Sciences at the Department of Humanities and Social Sciences, IIT-Jodhpur and at the Data, State and Society seminar series at TISS (February 2020). Aasim was an invited speaker on Data, Society and Culture at the 10th anniversary event of King's India Institute held in Delhi, 2022 and at the seminar on journalism and society at Goldsmiths University (London, 2023). Before moving to academia Aasim worked for many years in broadcast news journalism (CNN-IBN) and international development (Oxfam GB) and continues to write for popular news outlets, including Scroll.com, and is a regular contributor to The Book Review.",
      'faculty_College': "PhD (2018), King's College London",
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/aasim_0.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/aasim',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907463"',
      'faculty_Office_Address': 'B-202 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Digital Politics,Data and Governance,Social and Climate Movements,Civic Media and Journalism',
      'faculty_Teaching_Interests':
          'Digital Politics,Democracy and News,Data and Society,Critical Thinking '
    },
    {
      'faculty_Name': 'Abhijit Mitra',
      'faculty_EmailId': 'abhijit@iiitd.ac.in',
      'faculty_Department': 'ECE',
      'faculty_Position': 'Assistant Professor (ECE)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Abhijit Mitra received his Ph.D. from the Indian Institute of Technology Delhi (2017) under the funding of the British Telecom Fellowship. His experience has been in modeling and network planning for metro and core optical networks. He has been a reviewer in reputed journals like the Journal of Optical Communication and Networking (JOCN), and the Journal of Lightwave Technology (JLT). He has published in major venues like Proceedings of the IEEE, JOCN, JLT, Optical Fiber Communications (OFC) Conference, and the European Conference on Optical Communications (ECOC) with due industry-academic collaborations. Further, he has led funded projects by DST, MIETY, and DRDO in the capacity of PI/Co-PI and functioning as a collaborator in a project funded by the National Science Foundation (NSF), USA. He has been awarded DST Inspire Faculty Fellowship (2017-2022) by DST, British Council (Alumni Awards): Professional Achievement Awards (2019) by British Council, the prestigious Fulbright Post Doctoral Research Fellowship by the United States India Education Foundation (USIEF) and Sparkle-Marie Skłodowska-Curie Actions (MSCA) Cofund Fellowship (2022, not availed). Overall he has 10 years of research experience in Transport Optical Networks.',
      'faculty_College': 'PhD (2017), IIT Delhi',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/abhijit_0.jpg',
      'faculty_LinkedIn_Url': 'https://www.linkedin.com/in/abhijit2/',
      'faculty_Website_Url': 'https://iiitd.ac.in/abhijit',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907542"',
      'faculty_Office_Address': 'A-207 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Multi-band Optical Networks,Space Division Multiplexing,Quantum Key Distribution',
      'faculty_Teaching_Interests':
          'Digital Communication Systems,Next Generation Optical Networks'
    },
    {
      'faculty_Name': 'Aman Parnami',
      'faculty_EmailId': 'aman@iiitd.ac.in',
      'faculty_Department': 'HCD',
      'faculty_Position': 'Assistant Professor (HCD)',
      'faculty_Affiliated_Centers_And_Labs':
          'Center for Design and New Media (Supported by Tata Consultancy Services, a TCS Foundation Initiative)',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Aman Parnami recently received a PhD in Human-Computer Interaction with a minor in Industrial Design from the Georgia Institute of Technology. Prior to that, he has completed a Masters in HCI from the same institute and a dual degree in CSE from IIT Bombay. He had interned with Microsoft Research in Redmond and Intel in Hillsboro. His research interests include the development of rapid prototyping tools for novel wearable interactions and devices. Furthermore, he is passionately involved in the design of constructionist learning environments for CS courses. Besides academics, Aman regularly trains for the marathon and enjoys hiking as well as biking.',
      'faculty_College': 'PhD (2017), Georgia Institute of Technology',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/amanparnami.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/aman',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907521"',
      'faculty_Office_Address': 'A-405 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Wearable Computing,Design Research,Education Technology',
      'faculty_Teaching_Interests':
          'Maker-Oriented Learning,HCI,Wearable Computing, Interactive Product Design'
    },
    {
      'faculty_Name': 'Anand Srivastava',
      'faculty_EmailId': 'anand@iiitd.ac.in',
      'faculty_Department': 'ECE',
      'faculty_Position': 'Professor (ECE)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Anand Srivastava did his M.Tech. and Ph.D. from IIT Delhi and is currently working in IIIT Delhi as Professor in ECE department since Nov. 2014 and also Director in IIIT Delhi Incubation Center. I am also Adjunct faculty in Bharti School of Telecom Technology at IIT Delhi. Before joining IIIT Delhi, I was Dean & Professor in School of Computing and Electrical Engineering at Indian Institute of Technology Mandi, HP, India from Jan. 2012 to Nov. 2014. Prior to this, I was with Alcatel-Lucent-Bell Labs, India as solution architect for access and core networks for 2.5 years. My initial stint (∼ 20 years) was with Center for Development of Telematics (CDOT), a telecom research center of Govt. of India where I was Director and member of CDOT Board. During my stay in CDOT, I provided technical leadership and motivation to team of engineers engaged in the development of national level projects in the areas of Telecom Security Systems, Network Management System, Intelligent Networks, Operations Support Systems, Access Networks (GPON) and Optical Technology based products. Majority of these projects were completed successfully and commercially deployed in the public telecom network. I also carried out significant research work in the Photonics Research Lab, Nice, France, under the Indo-French Science & Technology Cooperation Program on “Special optical fibers and fiber-based components for optical communications” during 2007-2010 in different phases. I was also closely involved with ITU-T, Geneva in Study Group 15 and represented India for various optical networking standards meetings. Currently, I am driving VLC/LiFi standardization activities under the aegis of TSDSI. My research work is in the area of optical core & access networks, Vehicle-to-vehicle communications, Fiber-Wireless (FiWi) architectures, and Visible light communications.',
      'faculty_College': 'PhD (2003), IIT-Delhi',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/anand_1.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/anand',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907450"',
      'faculty_Office_Address': 'A-605 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Digital Communications,Wireless and Optical communications,Optical Networks',
      'faculty_Teaching_Interests':
          'Digital, Optical and Wireless Communication'
    },
    {
      'faculty_Name': 'Angshul Majumdar',
      'faculty_EmailId': 'angshul@iiitd.ac.in',
      'faculty_Department': 'ECE, CSE',
      'faculty_Position': 'Assistant Professor (Math)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Angshul Majumdar is a Professor at Indraprastha Institute of Information Technology, Delhi. He completed his Ph.D. from the University of British Columbia in 2012; he finished his thesis in a record time of less than two years. His research interests are in algorithms and applications of sparse signal recovery and low rank matrix recovery. Specifically, Angshul is interested in problems in biomedical signal processing and imaging. Angshul has written over 70 journal and conference papers since the inception of his research career in 2007. He has recently written a book on Compressed Sensing based MRI Reconstruction which is in print at Cambridge University Press.',
      'faculty_College': 'PhD (2012), University of British Columbia, Canada',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/angshul.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/angshul',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907451"',
      'faculty_Office_Address': 'A-606 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Sparse Recovery,Low-rank matrix completion,Medical Imaging,Biomedical Signal Processing,Hyper-spectral Imaging,Collaborative Filtering',
      'faculty_Teaching_Interests': 'Image Processing,Collaborative Filtering'
    },
    {
      'faculty_Name': 'Anmol Srivastava',
      'faculty_EmailId': 'anmol@iiitd.ac.in',
      'faculty_Department': 'HCD',
      'faculty_Position': 'Assistant Professor (HCD)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          "Anmol Srivastava specializes in Human-Computer Interaction. In 2019, he received his Ph.D. from India's pioneering UE and HCI Lab at IIT Guwahati. Anmol explores emerging technologies' potential to facilitate utility, usability, and creative self-expression in various contexts and use cases. His research output has received several awards at the national and international levels. Before joining IIITD, he headed the UX & Interaction Design Program and the XR & IxD Lab at the School of Design, UPES (Dehradun). His current research focuses on AR/VR, the Metaverse, and Tangible User Interfaces. Besides being passionate about Design Education, he is also a strong proponent of maker culture.",
      'faculty_College': 'PhD (2019), IIT Guwahati',
      'faculty_Image_Url': 'https://iiitd.ac.in/sites/default/files/anmol.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/anmol',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907467"',
      'faculty_Office_Address': 'A-404 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'AR/VR,The Metaverse,Tangible User Interfaces',
      'faculty_Teaching_Interests':
          'AR/VR,The Metaverse,Tangible User Interfaces'
    },
    {
      'faculty_Name': 'Anubha Gupta',
      'faculty_EmailId': 'anubha@iiitd.ac.in',
      'faculty_Department': 'ECE',
      'faculty_Position': 'Professor (ECE)',
      'faculty_Affiliated_Centers_And_Labs':
          'Member-Infosys Centre for Artificial Intelligence (CAI),Core Member-Center of Excellence in Healthcare, IIIT-Delhi,SBILab, Deptt. of ECE, IIIT-Delhi',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          "Prof. Anubha Gupta graduated with a Ph.D. degree in Electrical Engineering from IIT Delhi in 2006. She did her bachelor's and master's in ECE from Delhi University in 1991 and 1997, respectively. She started her professional career with the position of Assistant Director at ALL India Radio (through Indian Engineering Services) in 1993 and worked there until Feb. 1999. In Feb. 1999, she joined Netaji Subhas Institute of Technology (NSIT), Dwarka, Delhi. She worked as Assistant Professor in the Computer Engineering Department at NSIT for eight years. From July 2011 to Dec. 2013, she worked as associate professor at IIIT Hyderabad. In Dec 2013, she joined IIIT Delhi, where she is currently working as a Professor in the Department of Electronics and Communication Engineering.Apart from her engineering interests, Dr. Gupta is deeply interested in education policy issues. She did her second master's as a full time student from University of Maryland College Park, USA from 2008 to 2010. During this time, she worked as a project manager on a state policy related education project at the University System of Maryland, USA. On graduation, she worked as Director of Assessment at the Bowie State University, Maryland USA from Oct. 2010 to April 2011.She has authored/co-authored more than 100 technical papers in scientific journals and conferences. She has published research papers in both engineering and education. Her research interests include biomedical signal and image processing including fMRI, MRI, EEG, ECG signal processing, genomics signal processing in cancer research, Wavelets in deep learning, signal processing for communication engineering, and engineering education. Prof. Gupta is a recipient of SERB POWER Fellowship, 2021. She is a senior member of IEEE Signal processing Society and a member of IEEE Women in Engineering Society. She is an Associate Editor of IEEE Access journal, Associate Editor of IEEE Signal Processing Magazine eNewsletter, and Associate Editor, Frontiers in Neuroscience Methods. She is the technical committee member of BISP, IEEE Signal Processing Society for the term 1/1/2022 to 12/31/2024.",
      'faculty_College': 'PhD (2006), IIT-Delhi',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/anubhag.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/anubha',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907428"',
      'faculty_Office_Address': 'B-609 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Applications of Wavelet Transforms,Machine (Deep) Learning and Compressed Sensing,Sparse Reconstruction, FMRI/EEG/MRI/DTI Signal and Image Processing ,Genomics Signal Processing ,Signal Processing for Communication Engineering,and RF Energy Harvesting',
      'faculty_Teaching_Interests':
          'Courses related to signal and image processing,Wavelet and Multirate Analysis,Statistical Signal Processing'
    },
    {
      'faculty_Name': 'Anuj Grover',
      'faculty_EmailId': 'anuj@iiitd.ac.in',
      'faculty_Department': 'ECE',
      'faculty_Position': 'Associate Professor (ECE)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Dr. Anuj Grover has obtained Ph.D. from IIT Delhi in 2015, MS (Electronic Circuits and Systems) from UCSD in 2003, and B Tech (EE) from IIT Delhi in 2000. Prior to joining IIIT-Delhi, he had been working as Principal Engineer - Member of Technical Staff at STMicroelectronics, Greater NOIDA. He has been associated with IIIT-Delhi as a Guest Faculty since January 2018. In more than 18 years of experience in the semiconductor industry as a Memory Designer, he has worked on a wide range of technologies like Bulk CMOS, BCD, Imaging, UTBB-FDSOI CMOS, e-NVM across a range of feature sizes from 22nm to 0.35um. He has more than 25 publications across IEEE journals and conferences.He has strong interest in Systematic Innovation and is trained on applying Theory of Inventive Problem Solving (TRIZ). He has been awarded TRIZ Level-3 Certification from MIT and MATRIZ. He has also been certified by World Intellectual Property Organization (WIPO) on application of TRIZ for patents. He has been a STUniversity certified trainer on a program "From Creativity to Innovation". He has 5 granted patents and more than 10 patent applications in different stages of filing.His current research interests include Ultra Low Power In-Memory Compute for edge computing and machine learning applications; safety and security in hardware; and error resilient energy efficient systems.\nHe is also a Franklin Covey certified trainer for 7 Habits of Highly Effective People Signature Program and would be keen to bring this program to IIIT-D for faculty, staff and students.',
      'faculty_College': 'PhD (2015), IIT-Delhi',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/anujg_0.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/anujg',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907494"',
      'faculty_Office_Address': 'A-610 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Ultra Low Power In-Memory Compute for edge computing and machine learning applications, Safety and security in hardware; and Error resilient energy efficient systems',
      'faculty_Teaching_Interests':
          'Memory Design,VLSI Design, Solid State Devices, Theory of Inventive Problem Solving\n\n'
    },
    {
      'faculty_Name': 'Anuradha Sharma',
      'faculty_EmailId': 'anuradha@iiitd.ac.in',
      'faculty_Department': 'Math',
      'faculty_Position': 'Professor (Math)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Anuradha Sharma is a Professor in the Department of Mathematics at IIIT-Delhi. She received B.Sc. degree with Honours in Mathematics, and M.Sc. and Ph.D. degrees in Mathematics from Centre for Advanced Study in Mathematics, Panjab University, Chandigarh, India, in 2000, 2002, and 2006, respectively. She was awarded a University Gold Medal for standing first in M.Sc. Prior to joining IIIT Delhi, she has worked as an Assistant Professor in the Department of Mathematics at IIT Delhi for around five and a half years and as an Assistant Professor in the Centre for Advanced Study in Mathematics, Panjab University, Chandigarh for around three years. At IIT-Delhi, she received the Kusuma Outstanding Young Faculty Fellowship. She works in Algebraic Coding Theory. Her other research interests include Number Theory and Algebra. She has around 40 research publications in reputed international venues including but not limited to Finite Fields and Applications, Discrete Mathematics, IEEE Transactions on Information Theory, etc. She has also published a book titled "Codes and Modular Forms: A Dictionary" jointly with Minjia Shi, YoungJu Choie and Patrick Solé. Her Erdős number is 3',
      'faculty_College': 'PhD (2006), Panjab University, Chandigarh, India',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/anuradhas.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/anuradha',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907534"',
      'faculty_Office_Address': 'B-311 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Algebraic Coding Theory, Number Theory and Algebra',
      'faculty_Teaching_Interests':
          'Algebraic Coding Theory, Number Theory,Algebra, Quantum error-correction ,DNA error-correction'
    },
    {
      'faculty_Name': 'Arani Bhattacharya',
      'faculty_EmailId': 'arani@iiitd.ac.in',
      'faculty_Department': 'CSE,ECE',
      'faculty_Position': 'Assistant Professor (CSE, ECE)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Arani Bhattacharya earned his Ph.D. degree holder from Stony Brook University in Computer Science in 2019. His research experience is in the general areas of wireless networks, with a focus on applying algorithms, formal verification, and machine learning to different emerging applications. He has co-authored over 20 publications in different reputed venues. Before joining IIIT-Delhi, Arani has worked as a postdoctoral researcher at KTH Royal Institute of Technology, Stockholm and as a research intern at IMDEA Networks Institute, Madrid. He regularly serves as a reviewer for several top-tier journals such as IEEE/ ACM Transactions on Networking, IEEE Transactions on Wireless Communications and IEEE Transactions on Mobile Computing.',
      'faculty_College': 'PhD (2019), Stony Brook University, USA',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/arani.jpg',
      'faculty_LinkedIn_Url':
          'https://www.linkedin.com/in/arani-bhattacharya-7a6a4a69/',
      'faculty_Website_Url': 'https://iiitd.ac.in/arani',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907434"',
      'faculty_Office_Address': 'B-510 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Low latency compute and machine learning services, Video streaming and physical layer of wireless networks',
      'faculty_Teaching_Interests':
          'Statistical Machine Learning, Deep Learning,Digital Image Processing'
    },
    {
      'faculty_Name': 'Arjun Ray',
      'faculty_EmailId': 'arjun@iiitd.ac.in',
      'faculty_Department': 'CB',
      'faculty_Position': 'Assistant Professor (CB)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Dr. Arjun Ray is a computational structural biologist and earned his Ph.D. degree from CSIR-IGIB. His formal education in the field of chemistry and biophysics led him to be interested in understanding how biological processes are carried out by three-dimensional interactions. His previous researches include developing methods and tools in the field of structure prediction and force distributed analysis of lipids, deciphering mechanistic understanding of interactions between various biological molecules and working with multi-scale systems. As a structural biologist, he has been regularly working with techniques for structure prediction, molecular dynamics simulations and biomolecular docking. Along with his research endeavours, he has held several positions such former President of Regional Student Group (India) for the International Society for Computational Biology.',
      'faculty_College': 'Ph.D. CSIR-IGIB',
      'faculty_Image_Url': 'https://iiitd.ac.in/sites/default/files/arjunr.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/arjun',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907438"',
      'faculty_Office_Address': 'A-310 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Deciphering the mechanism of CRISPR-Cas9, Elucidating molecular interactions in the reverse cholesterol pathway, Structural genomic problems',
      'faculty_Teaching_Interests':
          'Biophysics, Computer-aided Drug Design, Protein biology'
    },
    {
      'faculty_Name': 'Arun Balaji Buduru',
      'faculty_EmailId': 'arunb@iiitd.ac.in',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Assistant Professor (CSE, HCD)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Arun Balaji Buduru is an assistant professor at Indraprastha Institute of Information Technology, Delhi. He received his Ph.D. in Computer Science, specializing in Information Assurance, at Arizona State University in 2016. His research interests include cyber security, reinforcement learning and stochastic planning. He received his B.E. degree in Computer Science in 2011 from Anna University at Chennai, India. He has worked as a research intern as part of Cisco IoT Architecture Group. His current research focuses on adaptive user re-authentication on touch-based devices, predicting security breaches in critical cyber infrastructures, and user behavior based adaptive IoT device reconfiguration',
      'faculty_College': 'PhD (2016), Arizona State University, USA',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/arunb.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/arunb',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907469"',
      'faculty_Office_Address': 'B-504 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Cyber security,Reinforcement learning and stochastic planning',
      'faculty_Teaching_Interests':
          'Computer Security Privacy and User Behavioral Modeling'
    },
    {
      'faculty_Name': 'Ashish Kumar Pandey',
      'faculty_EmailId': 'ashish.pandey@iiitd.ac.in',
      'faculty_Department': 'Math',
      'faculty_Position': 'nan',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'He obtained his Ph.D. in Mathematics from the University of Illinois at Urbana-Champaign, USA in April 2018. He completed his Integrated M.Sc. in Mathematics from National Institute of Science Education and Research (NISER), Bhubaneswar, India in May 2012. His primary area of research is Partial Differential Equations (PDEs). He tries to understand existence, well-posedness, stability or instability of solutions of nonlinear PDEs arising as physical models. He uses tools from Harmonic analysis and Operator theory.',
      'faculty_College':
          'Ph.D. (2018), University of Illinois at Urbana-Champaign, USA.',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/ashishpandey.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/ashishk',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907461"',
      'faculty_Office_Address': 'B-307 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests': 'Partial Differential Equations (PDEs)',
      'faculty_Teaching_Interests':
          'Stability or instability of solutions of nonlinear PDEs arising as physical models'
    },
    {
      'faculty_Name': 'Bapi Chatterjee',
      'faculty_EmailId': 'bapi@iiitd.ac.in',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Assistant Professor (CSE)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Before joining IIIT-Delhi, Dr. Chatterjee worked as an ISTPlus Postdoc Fellow at the Institute of Science and Technology Austria for two and a half years. Prior to that, he worked as a Researcher with IBM India Research Lab for two years post his doctoral studies. Dr. Chatterjee obtained a Ph.D. in Computer Science and Engineering from Chalmers University of Technology, Gothenburg, Sweden in January 2018. His current research interests are Distributed Machine Learning, Concurrent Data Structures, Neural Architecture Search, and Learned Index Structures.',
      'faculty_College':
          'PhD (2018), Chalmers University of Technology, Sweden',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/bapi.jpg',
      'faculty_LinkedIn_Url': 'https://www.linkedin.com/in/bapichatterjee/',
      'faculty_Website_Url': 'https://iiitd.ac.in/bapi',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907371"',
      'faculty_Office_Address': 'B-408 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Distributed Machine Learning,Concurrent Data Structures,Neural Architecture Search,Learned Index Structures',
      'faculty_Teaching_Interests':
          'Data Structures,Parallel/Distributed/High-performance Computing,Machine Learning,Optimization and related subjects'
    },
    {
      'faculty_Name': 'Chanekar Prasad Vilas',
      'faculty_EmailId': 'prasad@iiitd.ac.in',
      'faculty_Department': 'ECE',
      'faculty_Position': 'Assistant Professor (ECE)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Dr. Chanekar Prasad Vilas received his undergraduate degree in Mathematics and Computing from the Indian Institute of Technology, Kharagpur, India and an AMIE degree in Mechanical Engineering from the Institution of Engineers, India. He then obtained M.Sc. and Ph.D. degrees in Mechanical Engineering from the Indian Institute of Science, Bangalore, India and the University of Maryland, College Park, USA respectively. He was a Post-Doctoral researcher in the Department of Mechanical and Aerospace Engineering at the University of California, San Diego, USA.',
      'faculty_College': 'PhD (2018), University of Maryland, USA',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/chanekar.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/chanekar',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907374"',
      'faculty_Office_Address': 'B-610 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Kinematics,Dynamics,Control and optimization of large-scale engineering systems with applications to system co-design, Robotics, Renewable Energy Systems, Power Networks, Neuroscience',
      'faculty_Teaching_Interests': 'Optimal control,Nonlinear control,Robotics'
    },
    {
      'faculty_Name': 'Debajyoti Bera',
      'faculty_EmailId': 'dbera@iiitd.ac.in',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Associate Head (CSE), Associate Professor (CSE)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Debajyoti Bera is currently an Associate Professor in IIIT-Delhi. He received Ph.D. in Computer Science from Boston University in 2010, and B.Tech. in Computer Sc. and Engg. from IIT-Kanpur in 2002. He is currently involved in active research on topics in quantum complexity, graph algorithms and privacy issues in online services. His usual areas of research interest spans quantum computing, algorithms, theoretical aspects of security and privacy and algorithmic challenges in other domains like database, networking, etc. Apart from theoretical computer science, he is also interested in open-source development and computer systems. When not engaged in academic thoughts, he prefers to indulge in photography, music or reading.',
      'faculty_College': 'PhD (2009), Boston University, USA',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/debajyoti.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/dbera',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907442"',
      'faculty_Office_Address': 'B-508 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Algorithms,Complexity Theory,Quantum Computing',
      'faculty_Teaching_Interests':
          'Algorithms,Complexity Theory,Quantum Computing'
    },
    {
      'faculty_Name': 'Debarka Sengupta',
      'faculty_EmailId': 'debarka@iiitd.ac.in',
      'faculty_Department': 'CSE,CB',
      'faculty_Position': 'Associate Professor (CSE, CB)',
      'faculty_Affiliated_Centers_And_Labs':
          'Infosys Centre for Artificial Intelligence,Centre for Computational Biology',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Debarka is an Associate Professor of Computational Biology and Computer Science at IIIT-Delhi. He is also an honorary Associate Professor at the Queensland University of Technology-Brisbane. Debarka carried out his doctoral and post-doctoral research in the Machine Intelligence Unit of the Indian Statistical Institute and Genome Institute of Singapore, respectively. His group has been among the first to introduce big data algorithms in the field of single-cell genomics. He received INSPIRE faculty Award in 2015 by the Government of India. His lab invented and commercialized a panel of eleven platelet genes to track the early onset of cancer. ',
      'faculty_College': 'PhD, Jadavpur University, India',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/debarka.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/debarka',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907446"',
      'faculty_Office_Address': 'A-306 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Computational Genomics, Machine Learning, Bioinformatics',
      'faculty_Teaching_Interests':
          'Algorithms, statistics, machine learning, computational biology'
    },
    {
      'faculty_Name': 'Debika Banerjee',
      'faculty_EmailId': 'debika@iiitd.ac.in',
      'faculty_Department': 'Math',
      'faculty_Position': 'Assistant Professor (Math)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Dr. Debika Banerjee obtained Ph.D. in Mathematics from Harish-Chandra Research Institute, Allahabad in 2017 and M.Sc. in Mathematics from IIT Kanpur in 2011. Prior to joining IIIT-Delhi, she was a National Post Doctoral Fellow (NPDF) at IISER Pune from 2017 to 2019. She worked as a Post Doctoral Fellow at Technion, Israel from 2016 to 2017.',
      'faculty_College':
          'Ph.D. (2017), Harish-Chandra Research Institute, Allahabad',
      'faculty_Image_Url': 'https://iiitd.ac.in/sites/default/files/debika.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/debika',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907358"',
      'faculty_Office_Address': 'B-310 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests': 'Analytic and Probabilistic Number Theory',
      'faculty_Teaching_Interests':
          'Real Analysis,Complex Analysis,Algebra,Number Theory'
    },
    {
      'faculty_Name': 'Dhruv Kumar',
      'faculty_EmailId': 'dhruv.kumar@iiitd.ac.in',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Assistant Professor (CSE)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Dhruv Kumar is a PhD in Computer Science from University of Minnesota, Twin Cities, USA. He did his post-doc from Microsoft Research. His research is centered around building large scale systems for distributed analytics. His work has been published in venues such as ACM SIGMETRICS, ACM/IEEE SEC, USENIX HotEdge, ACM EdgeSys. Dhruv has been a recipient of 3M Science and Technology fellowship. During his PhD, he has also interned with Google Cloud, California. He graduated from BITS, Pilani in 2014 with a bachelors in Computer Science. At BITS Pilani, he did research on designing and implementing high performance algorithms for shared and distributed memory systems. Prior to joining the PhD program at UMN, Dhruv worked on optimizing the data processing pipelines at Goldman Sachs, Bengaluru.',
      'faculty_College':
          'Ph.D. (2022), University of Minnesota, Twin Cities, USA',
      'faculty_Image_Url': 'https://iiitd.ac.in/sites/default/files/dhruvk.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/dhruv',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907379"',
      'faculty_Office_Address': 'A-506 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Systems for AI,AI for Systems, Privacy and Security in AI, Technology Education for the Common People',
      'faculty_Teaching_Interests':
          'Operating Systems,Databases\n,Cloud Computing, Data Structures and Algorithms'
    },
    {
      'faculty_Name': 'Diptapriyo Majumdar',
      'faculty_EmailId': 'diptapriyo@iiitd.ac.in',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Assistant Professor (CSE)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Dr. Diptapriyo Majumdar obtained his Ph.D. degree in Theoretical Computer Science from The Institute of Mathematical Sciences (IMSc), Chennai, India in October 2018. He has spent 2 years 11 months at Royal Holloway, University of London, United Kingdom as a postdoctoral researcher. He did his B.Tech. in CSE from West Bengal University of Technology and M.Tech in Computer Science from Indian Statistical Institute, Kolkata, India. His research area is primarily in the field of algorithms. He has largely worked in fixed-parameter algorithms for graph theoretic problems. In addition, he has also explored FPT algorithms for CSP based problems arising in access control of information security.',
      'faculty_College':
          'Ph.D. (2018), The Institute of Mathematical Sciences (IMSc), Chennai',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/diptapriyo.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/diptapriyo',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907373"',
      'faculty_Office_Address': 'B-501 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Parameterized Complexity, Graph Algorithms, FPT algorithms for problems arising in access control',
      'faculty_Teaching_Interests':
          'Courses related to algorithms,Discrete Mathematics, Theoretical Computer Science,Optimization'
    },
    {
      'faculty_Name': 'Donghoon Chang',
      'faculty_EmailId': 'donghoon@iiitd.ac.in',
      'faculty_Department': 'CSE,Maths',
      'faculty_Position': 'Associate Professor (CSE, Maths)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Bachelor of Mathematics (2001), Korea University, Master of Information Security & Cryptography (2003), Korea University, PhD of Information Security & Cryptography (2008), Korea University, Researcher at University of Waterloo, Canada (2006) Post Doc at Columbia University, USA (2008-2009), Researcher at Computer Security Division, National Institute of Standards and Technology (NIST), USA (2009-2012), Associate Professor, IIIT-Delhi, India (2012-present)',
      'faculty_College': 'PhD (2008), Korea University, Korea',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/donghoon.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/donghoon',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907465"',
      'faculty_Office_Address': 'B-502 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Cryptography, Cryptanalysis, Cyber Security,Information Theory',
      'faculty_Teaching_Interests':
          'Cryptography,Information Theory,Linear & Abstract Algebra,Number Theory.'
    },
    {
      'faculty_Name': 'G.P.S. Raghava',
      'faculty_EmailId': 'raghava@iiitd.ac.in',
      'faculty_Department': 'CB',
      'faculty_Position': 'Head, Professor (CB)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Dr. G. P. S. Raghava received his M.Tech from IIT Delhi and PhD from Institute of Microbial Technology, Chandigarh. He worked as Postdoctoral fellow at Oxford University UK (1996-98), Bioinformatics specialist at UAMS, USA (2002-3 & 2006) and visiting professor at POSTECH, South Korea (2004). He worked as scientist for 30 years (1986-2016) in Institute of Microbial Technology, Chandigarh. His group developed more than 250 web servers, 200 research papers, 80 Copyrights/patents, 35 databases and mirror sites. He got following major awards/recognition i) Shanti Swarup Bhatnagar Award in Biological Science ii) “National Bioscience Award for Carrier Development” for year 2005-2006 (by Department of Biotechnology, Govt. India); iii) J. C. Bose national fellowship 2010 by DST; iv) fellow of National Academy of Sciences (F.N.A.Sc); and v) fellow of Indian Academy of Science (F.A.Sc.) Bangalore.',
      'faculty_College':
          'PhD (1996), Institute of Microbial Technology, Chandigarh',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/raghava.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/raghava',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907444"',
      'faculty_Office_Address': 'A-302 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Application of computer science in the field of biomedical,Artificail intelligence based models for desiging drugs, vaccines and disease biomarkers,Development of open source applications (web servers, standalone software, mobile apps) for serving scientific community working in healthcare',
      'faculty_Teaching_Interests':
          'Application of Artificial Intelligence in Biomedical Sciences,Big Data Mining in Healthcare'
    },
    {
      'faculty_Name': 'Ganesh Bagler',
      'faculty_EmailId': 'bagler@iiitd.ac.in',
      'faculty_Department': 'CB',
      'faculty_Position': 'Associate Professor (CB)',
      'faculty_Affiliated_Centers_And_Labs':
          'Complex Systems Laboratory,Infosys Centre for Artificial Intelligence (CAI)',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Ganesh Bagler is a computational researcher trained in physics, computer science, and computational biology. Prof. Bagler is well-known for his pioneering research in ‘Computational Gastronomy.’ By building keystone data repositories, algorithms, and applications, he has established the foundations of this emerging data science that blends food with artificial intelligence. Trailblazing research from his lab has significantly contributed to this niche area that deals with food, flavors, nutrition, and public health. A prolific interdisciplinary scientist, voracious reader, science communicator, and TEDx speaker, Ganesh Bagler is an explorer driven by curiosity. He enjoys probing the structure, function, evolution, and design of complex systems (proteins, brain, health, cuisines, languages, and creativity). Prof. Bagler has an audacious dream of transforming the global food landscape by ‘Making Food Computable.’',
      'faculty_College':
          'Ph.D. (2007), CSIR-Centre for Cellular and Molecular Biology',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/gbagler.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/bagler',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907443"',
      'faculty_Office_Address': 'A-305 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Complex Systems,Computational Gastronomy,Computational Biology,Network Science,Bioinformatics,Computational Creativity',
      'faculty_Teaching_Interests':
          'Computational and Systems Biology,Network Science,Network Biology,Computational Gastronomy,Computational Creativity,Philosophy of Science'
    },
    {
      'faculty_Name': 'Gaurav Ahuja',
      'faculty_EmailId': 'gaurav.ahuja@iiitd.ac.in',
      'faculty_Department': 'CB',
      'faculty_Position': 'Associate Professor (CB)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Gaurav Ahuja graduated summa cum laude from the University of Cologne, Germany with Ph.D. in Natural Sciences. He is a molecular biologist by training and possesses a vast experience in functional genomics, especially in dissecting complex biological mechanisms using genome-editing and next generation sequencing-based techniques. After the completion of his Ph.D. degree, he worked as a Post Doctoral Fellow at several renowned institutes, including Center for Molecular Medicine Cologne, Max Planck Institute for Ageing and Lee Kong Chian School of Medicine, Singapore. During this period he worked on multiple model systems, including human pluripotent stem cells, zebrafish, mice and killifish. He has published 14 research articles in peer-reviewed International journals (~250 citations). In addition to this, he also reviewed articles submitted to Nature Publishing Group (Cell Death & Diseases and Scientific Reports). Recently, Dr. Ahuja was shortlisted for the prestigious INSPIRE Faculty Fellowship.',
      'faculty_College': 'Ph.D. (2015), University of Cologne, Germany',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/gauravahuja.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/gauravahuja',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907475"',
      'faculty_Office_Address': 'A-303 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Identification,Deorphanization and characterization of ectopically expressed GPCRS',
      'faculty_Teaching_Interests':
          'Chemoinformatics,Genetics,Molecular Biology,Biostatistics'
    },
    {
      'faculty_Name': 'Gaurav Arora',
      'faculty_EmailId': 'gaurav@iiitd.ac.in',
      'faculty_Department': 'SSH',
      'faculty_Position': 'Assistant Professor (SSH)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Gaurav Arora received his Ph.D. in Economics at Iowa State University in January, 2017. As part of his Ph.D. dissertation work, he combined applied economics models with remote sensing tools to study the impacts of local infrastructure, climate change and conservation policy on regional land use changes for Agroecosystems. He also designed and implemented a satellite image-processing algorithm to characterize land use change using historical Landsat sensor data. He was awarded James R. Prescott scholarship in 2016 for outstanding creativity in research, and Earl O. Heady Fellowship in 2012 for academic excellence at the Department of Economics, Iowa State University. Prior to his Ph.D., Gaurav received Master of Science in Agricultural and Resource Economics at the University of Arizona, and Bachelor of Technology in Environmental Engineering at Indian School of Mines, Dhanbad.',
      'faculty_College': 'Ph.D. (2017), Iowa State University',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/gaurava.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/gauravahuja',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907547"',
      'faculty_Office_Address': 'B-206 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Natural Resource & Agricultural Economics,Ecological Economics,Applied Econometrics,Industrial Organization,Applied Game Theory,Spatial Analyses,Remote',
      'faculty_Teaching_Interests':
          'Applied econometrics,Applied microeconomics,Spatial statistics and spatial econometrics'
    },
    {
      'faculty_Name': 'Gayatri Nair',
      'faculty_EmailId': 'gayatri@iiitd.ac.in',
      'faculty_Department': 'SSH',
      'faculty_Position': 'Assistant Professor (SSH)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          "Gayatri received her M.Phil (2012) and PhD (2016) in Sociology from the Centre for the Study of Social Systems, Jawaharlal Nehru University, New Delhi. Her research interests lie in urban informal labour and livelihood patterns with an emphasis on the question of technology, caste and gender. With a focus on political economy, she has published work examining the links between caste, gender and cultures of modernity, working caste lives and popular culture. She has published a book on her doctoral research titled 'Set Adrift; Capitalist Transformations and Community Politics Along Mumbai's Shore published by Oxford University Press (2021).",
      'faculty_College': 'PhD (2016), Jawaharlal Nehru University, New Delhi',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/gayatri.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/gayatri',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907362"',
      'faculty_Office_Address': 'B-212 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Informal Labour,Urban Informalities,Technology, Gender, and Caste,Digital work and platform economy, Future of Work(ers),Resource-based livelihoods',
      'faculty_Teaching_Interests':
          'Sociological Theory,Technology and Work, Economic Sociology,Urban Sociology'
    },
    {
      'faculty_Name': 'Jainendra Shukla',
      'faculty_EmailId': 'jainendra@iiitd.ac.in',
      'faculty_Department': 'CSE,HCD',
      'faculty_Position': 'Assistant Professor (CSE, HCD)',
      'faculty_Affiliated_Centers_And_Labs':
          'Infosys Centre for Artificial Intelligence (CAI),Center for Design and New Media (Supported by Tata Consultancy Services, a TCS Foundation Initiative),Human-Machine Interaction Lab (HMI)',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Jainendra Shukla completed his Ph.D. in excellent grades with Industrial Doctorate Distinction and International Doctorate Distinction from Universitat Rovira i Virgili (URV), Spain in 2018. He is the recipient of the prestigious Industrial Doctorate research grant by AGAUR, Government of Spain in 2014. He is experienced in human-robot interactions and affect recognition using physiological signals. He is enthusiastic about empowering machines with adaptive interaction ability that can improve the quality of life in health and social care. His research has been disseminated in several journals and conferences of international reputation, including ACM CHI Conference on Human Factors in Computing Systems (CHI), Proceedings of the ACM on Interactive, Mobile, Wearable and Ubiquitous Technologies (IMWUT), IEEE Transactions on Affective Computing. Earlier, he obtained his M.Tech. degree in Information Technology with Specialization in Robotics from Indian Institute of Information Technology, Allahabad (IIIT-A) in 2012 and B.E. degree in Information Technology from the University of Mumbai in First Class with Distinction in 2009.',
      'faculty_College':
          'PhD (2018), Universitat Rovira i Virgili (URV), Spain',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/Jainendra.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/jainendra',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907523"',
      'faculty_Office_Address': 'A-410 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Affective Computing,Human-Computer Interaction,Social Robotics',
      'faculty_Teaching_Interests':
          'Affective Computing,Machine Learning\n,Social Robotics'
    },
    {
      'faculty_Name': 'Jaspreet Kaur Dhanjal',
      'faculty_EmailId': 'jaspreet@iiitd.ac.in',
      'faculty_Department': 'CB',
      'faculty_Position': 'Assistant Professor (CB)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'TRUE\n',
      'faculty_Bio':
          'Dr. Jaspreet Kaur Dhanjal received her PhD degree from Indian Institute of Technology Delhi (IITD) in 2019. She has then worked as a Postdoctoral Fellow at the National Institute of Advanced Industrial Science and Technology (AIST), Tsukuba Japan. Her research interests have been at the interface of computation, cellular and molecular biology. In particular, she is interested in studying cancer genomics for designing personalized therapeutics. She is also interested in exploring the mechanism of action of bioactive compounds from natural sources. She has co-authored over 30 papers in peer-reviewed international journals, 04 book chapters and over 10 international conference participation/presentations.',
      'faculty_College': 'PhD (2019), IIT-Delhi',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/jaspreet.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/jaspreet',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907522"',
      'faculty_Office_Address': '\nA-307 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Cancer genomics, personalized medicine, drug design and discovery',
      'faculty_Teaching_Interests':
          'Introduction to Quantitative Biology,Cell Biology and Biochemistry'
    },
    {
      'faculty_Name': 'Kaushik Kalyanaraman',
      'faculty_EmailId': 'kaushik@iiitd.ac.in',
      'faculty_Department': 'Math',
      'faculty_Position': 'Head, Assistant Professor (Math)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          "Kaushik Kalyanaraman is an applied and computational mathematician. He trained to be an electrical engineer (bachelor's and master's degrees), chose to be a computer scientist (doctoral degree) and now identifies as an applied mathematician. His degrees are from Anna University Chennai, Indian Institute of Technology Bombay, and the University of Illinois at Urbana-Champaign in that order. Kaushik's research interests are interdisciplinary and span applied math, computer science and engineering. His honors include a best paper award at ACM-SIAM SPM 2012, and being an invitee to the inaugural Heidelberg laureate forum in 2013. Kaushik has also had a brief industrial stint with the former TATA company Computational Research Labs in Pune, India before his Ph.D. and a research stint at Rensselaer Polytechnic Institute in Troy, NY after. Philosophies of computing, math and science are a side interest which he tries to cultivate during his personal time.",
      'faculty_College':
          'Ph.D. (2015), University of Illinois at Urbana-Champaign',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/kaushik.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/kaushik',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907537"',
      'faculty_Office_Address': 'B-302 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Applied and Computational Analysis,Geometry and Topology',
      'faculty_Teaching_Interests':
          'Scientific computing, numerical ODEs and PDEs'
    },
    {
      'faculty_Name': 'Kiriti Kanjilal',
      'faculty_EmailId': 'kanjilal@iiitd.ac.in',
      'faculty_Department': 'SSH',
      'faculty_Position': 'Head, Assistant Professor (SSH)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Kiriti Kanjilal completed his 5 year Integrated Masters in Economics at the University of Hyderabad in 2013 and defended his Ph.D. in Economics at Washington State University in May 2018. His dissertation was titled Essays in Behavioral Industrial Organization and Natural Resource Economics. His research interests are primarily in the fields of microeconomics, game theory, industrial organization, environmental economics and behavioral economics. He also has experience in conducting economic experiments. He uses Mathematica, Stata and z-Tree for research. Apart from research, he also has taught courses in macroeconomics and finance during his Ph.D.',
      'faculty_College': 'Ph.D. (2018), Washington State University',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/kanjilal.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/kanjilal',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907558"',
      'faculty_Office_Address': 'B-208 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Industrial Organization,Applied Game Theory,Behavioural and Experimental Economics,Natural Resource Economics',
      'faculty_Teaching_Interests':
          'Game Theory,Industrial Organization,Macroeconomics'
    },
    {
      'faculty_Name': 'Koteswar Rao Jerripothula',
      'faculty_EmailId': 'koteswar@iiitd.ac.in',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Assistant Professor (CSE)',
      'faculty_Affiliated_Centers_And_Labs':
          'Center for Design and New Media (Supported by Tata Consultancy Services, a TCS Foundation Initiative)',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Koteswar is currently working as an Assistant Professor at IIIT-Delhi in the CSE Department. He received his B.Tech degree from IIT Roorkee, India, in 2012, and PhD degree from Nanyang Technological University (NTU), Singapore, in 2017. In 2016, he did a research internship at Advanced Digital Sciences Center (ADSC), Singapore. He has also worked with Graphic Era and Lenskart earlier. His research interests are Computer Vision and Machine Learning. He is currently focusing primarily on object co-segmentation, saliency detection, semi-supervised learning and weakly supervised learning. Some of his works have been published in top/popular venues like CVPR, ECCV, TMM, TCSVT, etc.',
      'faculty_College':
          'PhD (2017), Nanyang Technological University (NTU), Singapore',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/koteswar.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/koteswar',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907433"',
      'faculty_Office_Address': 'B-405 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Computer Vision,Image Processing,Multimedia Systems,Machine Learning and Artificial Intelligence',
      'faculty_Teaching_Interests':
          'Computer Vision,Image Processing,Machine Learning and Programming'
    },
    {
      'faculty_Name': 'Manohar Kumar',
      'faculty_EmailId': 'manohar.kumar@iiitd.ac.in',
      'faculty_Department': 'SSH',
      'faculty_Position': 'Assistant Professor (SSH)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Manohar Kumar completed his PhD in Political Theory from LUISS University, Rome in 2013. He has a Masters in Development Studies from Tata Institute of Social Sciences, Mumbai and a Bachelors in Economics from Hindu College, University of Delhi.He is currently finishing a co-authored book project titled ‘Speaking Truth to Power. A Theory of Whistleblowing’ slated to be published in 2018.Prior to joining IIIT-Delhi, Manohar held postdoctoral fellowships at IIT Delhi (2015-2017) and AMSE, Aix Marseille University (2017-2018).',
      'faculty_College': 'PhD (2013), LUISS University, Rome',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/Manohar-Kumar.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/manohark',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907557"',
      'faculty_Office_Address': 'B-207 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Moral and Political Philosophy,Digital dissent,Digital citizenship,Whistleblowing,Civil disobedience,Democratic secrecy and epistemic injustice.',
      'faculty_Teaching_Interests':
          'Social and Political Philosophy,Applied Ethics,Moral Philosophy,Ethics of AI'
    },
    {
      'faculty_Name': 'Manuj Mukherjee',
      'faculty_EmailId': 'manuj@iiitd.ac.in',
      'faculty_Department': 'ECE',
      'faculty_Position': 'Assistant Professor (ECE)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Dr. Manuj Mukherjee received his PhD from the Indian Institute of Science in 2017. Following his PhD, he did a couple of stints as a postdoc, at Telecom Paris, France, and at Bar Ilan University, Israel. He has regularly published in top tier journals and conferences of IEEE Information Theory Society. He is the recipient of the Seshagiri Kaikini Medal from the Electrical Communication Engineering department of the Indian Institute of Science for the best PhD thesis in the year 2017-2018.His research interests include the broad neighborhood of information theory in general with a particular focus on multiparty communication.',
      'faculty_College':
          'Ph.D. (2017), Indian Institute of Science, Bengaluru, India',
      'faculty_Image_Url': 'https://iiitd.ac.in/sites/default/files/manuj.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/manuj',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907376"',
      'faculty_Office_Address': 'A-608 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Information Theory,Multiparty interactive communication,Interactive coding',
      'faculty_Teaching_Interests': 'nan'
    },
    {
      'faculty_Name': 'Md. Shad Akhtar',
      'faculty_EmailId': 'shad.akhtar@iiitd.ac.in',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Assistant Professor (CSE)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Md. Shad Akhtar completed his Ph.D. in Computer Science and Engineering from IIT Patna in 2019. He received his M.Tech from IIT (ISM), Dhanbad in 2014, and BEng from JMI, New Delhi, in 2009. He also has industry experience of more than two years with HCL Technologies Ltd. He has published research papers in various peer-reviewed conferences and journals of international repute. He has also served as the program committee member and reviewer for numerous international conferences and journals.His main areas of research are Sentiment and Emotion Analysis in the Natural Language Processing domain. Currently, his area of interest focuses on Dialog Management and Multimodal Analysis.',
      'faculty_College': 'PhD (2019), IIT Patna, India',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/shad.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/shad',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907365"',
      'faculty_Office_Address': 'B-406 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Sentiment Analysis,Emotion Analysis,Conversational Dialog Systems,Code-mixed Languages,Multimodal Analysis',
      'faculty_Teaching_Interests': 'Natural Language Processing,Deep Learning'
    },
    {
      'faculty_Name': 'Monika Arora',
      'faculty_EmailId': 'monika@iiitd.ac.in',
      'faculty_Department': 'Math',
      'faculty_Position': 'Assistant Professor (Math)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Monika Arora defended her Ph.D. thesis in Computational & Applied Mathematics from Old Dominion University, Virginia, USA in May 2018. She did her M.Sc. in Applied Statistics and Informatics (ASI) from Indian Institute of Technology (IIT), Bombay, India in May 2011. After her M.Sc. she worked for two years as a lead scientist in statistical modeling at a start up incubated by IIT-Bombay. Her current areas of research are count data and statistical modeling. She works on univariate and bivariate count models which are applied in various fields, e.g., health science, travel, insurance and ecology. Her research involves both theoretical and computational techniques to develop the models. She uses statistical softwares like R and SAS for her research.',
      'faculty_College': 'Ph.D. (2018), Old Dominion University, Virginia, USA',
      'faculty_Image_Url': 'https://iiitd.ac.in/sites/default/files/monika.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/monika',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907587"',
      'faculty_Office_Address': 'A-304 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests': 'Count data and statistical modeling',
      'faculty_Teaching_Interests':
          'Statistical Inference,Categorical data,Stochastic Processes'
    },
    {
      'faculty_Name': 'Mrinmoy Chakrabarty',
      'faculty_EmailId': 'mrinmoy@iiitd.ac.in',
      'faculty_Department': 'SSH',
      'faculty_Position': 'Assistant Professor (SSH)',
      'faculty_Affiliated_Centers_And_Labs':
          'Center for Design and New Media (Supported by Tata Consultancy Services, a TCS Foundation Initiative)',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Dr. Mrinmoy Chakrabarty carried out his doctoral training with a fellowship from the Interdisciplinary Program for Biomedical Sciences of Osaka University, Japan and earned his Ph.D. with Distinction at Osaka University Graduate School of Medicine in March 2017. He was a Post-Doctoral Research Fellow in the Dept. of Rehabilitation for Brain Functions at National Rehabilitation Center for Persons with Disabilities, Japan [WHO Collaborating Center] from April 2017 until joining IIIT-Delhi in December 2019. His present experimental research employs psychophysics, psychophysiology and neuroimaging with computational data analysis to study cognitive functions in samples of clinical as well as healthy human populations.',
      'faculty_College': 'PhD (2017), Osaka University, Japan',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/mrinmoy.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/mrinmoy',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907363"',
      'faculty_Office_Address': 'A-202 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Affective Cognitive Neuroscience,Visual-Spatial Cognition,Autism Spectrum Disorders,Decision Making,Learning-Memory,Anxiety Disorders',
      'faculty_Teaching_Interests': 'Learning and Memory,Decision Making'
    },
    {
      'faculty_Name': 'Mukesh Mohania',
      'faculty_EmailId': 'mukesh@iiitd.ac.in',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Professor (CSE)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Mukesh Mohania received his Ph.D. in Computer Science & Engineering from Indian Institute of Technology - Bombay, India in 1995. He was a faculty member in University of South Australia and Western Michigan University from 1995-2001, and then worked at IBM Research (India and Australia) for 18+ years till October 2019 as Distinguished Engineer.His research interests are on Information (structured and unstructured data) integration, master data management, AI based entity analytics, big data analytics and applications, and blockchain data management. His work in these areas has led to the development of new products and also influenced several existing IBM products. He has received several awards within IBM, such as "Best of IBM", “Outstanding Innovation Award”, "Outstanding Technical Achievement Award", and many more. He has published more than 120 Research papers in reputed International Conferences and Journals and has more than 50 granted patents. He has held several visible positions in academia and professional activities, like Adjunct Professor at Australian National University and University of Melbourne, VLDB 2016 Conference Organising Chair, ACM India Vice-President (2015-2017), ACM Distinguished Service Award Committee Chair (2017-18), Distinguished Speaker Program Chair (2015-17), and editorial board member in several journals and transactions. He is an ACM Distinguished Scientist, a recipient of ACM Outstanding Service Award, and an IEEE Meritorious Award. He was a member of IBM Academy of Technology, and IBM Master Inventor.',
      'faculty_College':
          'PhD (1995), Indian Institute of Technology Bombay, India',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/public/faculty/mukesh.jpg',
      'faculty_LinkedIn_Url':
          'https://www.linkedin.com/in/mukesh-mohania-4755606/',
      'faculty_Website_Url': 'https://iiitd.ac.in/mukesh',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907355"',
      'faculty_Office_Address': 'A-507 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Information Integration,Entity Discovery and Analytics,Big Data Analytics and Applications,Blockchain Data Management',
      'faculty_Teaching_Interests':
          'Information Management and Data Integration'
    },
    {
      'faculty_Name': 'Mukulika Maity',
      'faculty_EmailId': 'mukulika@iiitd.ac.in',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Assistant Professor (CSE)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Mukulika Maity joined as an assistant professor at the computer science department of IIIT- Delhi in April 2017. She received her M.Tech. + Ph.D. dual degree from computer science department of IIT Bombay in 2017. Her PhD advisors were Prof. Bhaskaran Raman and Prof. Mythili Vutukuru. She received her B.E. in 2010 in the computer science department of Bengal Engineering and Science University, Shibpur. Her research interests lie in developing networked systems solutions, designing solutions for dense WiFi networks, and developing mobile system solutions. She has been awarded the Early Career Research award by SERB in 2019. She is working on multiple projects funded by various organizations such as SERB, NSC. She is interested in developing solutions for unique systems/networking challenges faced by developing countries.',
      'faculty_College': 'PhD (2016), IIT Bombay, India',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/mukulikam.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/mukulika',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907471"',
      'faculty_Office_Address': 'B-509 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Networked Systems,Wireless Networks,Mobile Systems',
      'faculty_Teaching_Interests':
          'Computer Networks,Wireless Networks,Mobile computing'
    },
    {
      'faculty_Name': 'N. Arul Murugan',
      'faculty_EmailId': 'arul.murugan@iiitd.ac.in.',
      'faculty_Department': 'CB',
      'faculty_Position': 'Associate Professor (CB)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Dr. N. Arul Murugan, is a Ph.D. from Solid State and Structural Chemistry unit at Indian Institute of Science, Bangalore, India). He was awarded a Ph.D. degree in the year 2005 for his thesis contribution entitled "Molecular simulations of temperature induced disorder and pressure induced ordering in organic molecular crystals." After Ph.D., he was on postdoctoral visits to various institutes in Europe such as ULB (Brussels, Belgium), KTH (Stockholm, Sweden) and UPC (Barcelona, Spain) until 2011, and his research stays were supported generously by the prestigious fellowships from Belgian national fund for scientific research (FNRS), Wenner-Gren foundation and Spanish Ministry of Science and Innovation (for Juan de La Cierva fellowship). From the year 2011, he was employed as a researcher at the School of Biotechnology, KTH Royal Institute of Technology and from 2015 he was appointed as a Docent (Associate Professor) in theoretical chemistry and Biology at the same school. He has been involved in teaching and supervision at KTH since the year 2013.  His research focuses on the computational development of drugs and PET tracers/optical probes for neurodegenerative diseases such as Alzheimer\'s disease and Parkinson\'s disease and infectious diseases including Covid-19. His research is also devoted to the development of QM and machine learning based approaches for druggability prediction. He has published about 120 articles in international peer-reviewed journals including Sci.Adv., PNAS, JACS, Biosens.& Bioelectron., JMedChem, JCTC, JPClett., He has also written 3 book chapters and edited a book.  He is serving as an editorial board member for Scientific Reports and IJMS and is currently editing a special issue on Covid-19 therapeutics and diagnostics for the IJMS journal.',
      'faculty_College':
          'Ph.D. (2005), Indian Institute of Science, Bangalore, India',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/arulmurugan.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/arulmurugan',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"01126907372"',
      'faculty_Office_Address': 'A-311 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'ML and DL approaches for Druggability prediction,QM fragmentation based approaches for Druggability prediction,Parallel virtual screening in HPCs and GPUs for accelerated drugs discovery,Flexible docking assisted Drugs discovery,Atomistic simulation of virus-host cell interaction',
      'faculty_Teaching_Interests':
          'Algorithms in Computational Biology Cheminformatics'
    },
    {
      'faculty_Name': 'Nishad Patnaik',
      'faculty_EmailId': 'nishad@iiitd.ac.in',
      'faculty_Department': 'SSH',
      'faculty_Position': 'Assistant Professor (SSH)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Nishad received his PhD in philosophy from The New School for Social Research (NSSR), New York, U.S.A in 2013. He holds a M.A. in philosophy from NSSR, as well as a M.A. and M.Phil. in philosophy from Delhi University. His dissertation entitled, “Time, Space and Finitude; Kant and Husserl on the Question of Transcendental Logic” received the ‘Alfred Schutz Memorial Award in Philosophy and Sociology’. In addition to his research interests in Kantian transcendental Idealism, and Husserlian phenomenology, Nishad’s other areas of research include Social and Political Philosophy, Marx and the Critical Theory tradition, Ethics, and the Philosophy of Technology. He is currently engaged in writing a book length manuscript on the genealogy of nationalist identity and its apparently paradoxical reassertion in the context of the hegemony of the contemporary capitalist world order.Before joining IIITD, he was a visiting assistant professor at IIIT Hyderabad (2018-19), Visiting Fellow at J.N.U. (2015-17), and held visiting faculty positions at IIT Delhi (2015-16), St. Stephen’s College, Delhi (2016-17) and Westchester Community College, New York, 2013-14.',
      'faculty_College': 'PhD (2013), NSSR, New York, USA',
      'faculty_Image_Url': 'https://iiitd.ac.in/sites/default/files/nishad.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/nishad',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907364"',
      'faculty_Office_Address': 'A-205 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Kantian transcendental Idealism,Husserlian phenomenology,Social and Political Philosophy',
      'faculty_Teaching_Interests':
          'Kantian transcendental Idealism,Husserlian phenomenology,Social and Political Philosophy'
    },
    {
      'faculty_Name': 'Ojaswa Sharma',
      'faculty_EmailId': 'ojaswa@iiitd.ac.in',
      'faculty_Department': 'CSE,Maths',
      'faculty_Position': 'Head, Associate Professor (CSE, Math)',
      'faculty_Affiliated_Centers_And_Labs':
          'Graphics Research Group (GRG),Center for Design and New Media (Supported by Tata Consultancy Services, a TCS Foundation Initiative)',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Ojaswa Sharma is an associate professor at the Indraprastha Institute of Information Technology Delhi. He completed his Ph.D. in Mathematics and Computer Science from the Technical University of Denmark, Denmark. He has more than four years of experience with corporate R&D. His research spans various aspects of Computer Graphics, and Computational Geometry. In particular his work focuses on Geometry creation and reconstruction, Virtual/Augmented Reality (AR/VR), Volume rendering, and high performance computing on GPU. He leads the Graphics Research Group (GRG) at IIIT-Delhi.',
      'faculty_College': 'PhD (2010), Technical University of Denmark, Denmark',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/ojaswa.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/ojaswa',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907476"',
      'faculty_Office_Address': 'A-511 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Computer graphics and geometry with focus on Virtual and Mixed reality (VR/MR),Volume rendering,3D reconstruction,High performance computing on GPU',
      'faculty_Teaching_Interests':
          'Computer graphics and geometry with focus on Virtual and Mixed reality (VR/MR),Volume rendering,3D reconstruction,High performance computing on GPU'
    },
    {
      'faculty_Name': 'Pankaj Jalote',
      'faculty_EmailId': 'jalote@iiitd.ac.in',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Distinguished Professor (CSE)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Pankaj Jalote is currently a Distinguished Professor (CSE). He was the founding Director of IIIT-Delhi from 2008-2018. Earlier, he has also been an Assistant Professor at University of Maryland College Park, Professor and Head of Computer Science Department at IIT Kanpur, and Chair Professor at IIT Delhi, . He has also been Vice President at Infosys for 2 years, Visiting Researcher at Microsoft in Redmond for 1 year, and Interim Vice Chancellor of Delhi Technological University (DTU) for six months. He has a B.Tech. from IIT Kanpur, MS from Pennsylvania State University, and Ph.D. from University of Illinois at Urbana-Champaign. He is the author of five books, some of which have been translated in Chinese, Japanese, Korean etc, and the Indian edition of his text on Software Engineering was adjudged the bestselling book by the publisher. His main area of interest is Software Engineering and Higher Education. He has served on the editorial boards of IEEE Transactions on Software Engineering, Intl. Journal on Empirical Software Engineering, and IEEE Trans. on Services Computing. He is a Fellow of the IEEE and INAE.',
      'faculty_College':
          'PhD (1985), University of Illinois at Urbana Champaign, USA',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/jalote.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/jalote',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907499"',
      'faculty_Office_Address': 'A-705 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Software quality, process improvement,Higher Education in India',
      'faculty_Teaching_Interests':
          'Software Engineering, Quantitative Methods in Software Engineering E-Commerce, Effective Teaching, Technical Communication.'
    },
    {
      'faculty_Name': 'Paro Mishra',
      'faculty_EmailId': 'paro.mishra@iiitd.ac.in',
      'faculty_Department': 'SSH',
      'faculty_Position': 'Assistant Professor (SSH)',
      'faculty_Affiliated_Centers_And_Labs':
          'Center for Design and New Media (Supported by Tata Consultancy Services, a TCS Foundation Initiative)',
      'faculty_Authorization': 'TRUE\n',
      'faculty_Bio':
          "Paro received her Ph.D. from the Department of Humanities and Social Sciences, Indian Institute of Technology, Delhi in 2017. Her core research interests lie at the intersection of Gender and Technology – New Reproductive Technologies (NRTs) and Information/ Digital Technologies, in particular. She has published on intimate migrations, masculinity, aging, care circulation, care work and gendered surveillance. Paro has received several fellowships and grants from the Netherlands Institute for Advanced Studies, University Grants Commission, IIT Delhi and the Indian Council of Social Science Research. She has recently finished a project on sex-selective technologies, male marriage squeeze and cross-cultural intimacies funded by the Indian Council of Social Science Research (2018). Her current research is examining intersections of Gender, Health and Digital Technologies with a focus on emerging FemTech Landscape in India. This project is funded by IIITD-IITD MFIRP Scheme. Select publications include special issues co-editorship for Asian Bioethics Review (2021) and Asian Journal of Women's Studies and in Journals like Anthropology and Aging, The Sociological Review, Economic & Political Weekly, and Society and Culture in South Asia.",
      'faculty_College': 'PhD (2017), IIT-Delhi',
      'faculty_Image_Url': 'https://iiitd.ac.in/sites/default/files/paro.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/paro',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907570"',
      'faculty_Office_Address': 'B-209 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Gender and Technology,New reproductive Technologies,Digital Technologies,Demographic Anthropology,Intimate Relations,Migration and Transnationalism',
      'faculty_Teaching_Interests':
          'Enhancement Technologies and Body,Contemporary Indian Society,Digital Intimacy,Gender Studies, Migration and Transnationalism'
    },
    {
      'faculty_Name': 'Piyus Kedia',
      'faculty_EmailId': 'piyus@iiitd.ac.in',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Assistant Professor (CSE)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Dr. Piyus has obtained his Ph.D. from IIT Delhi and subsequently worked as a post-doctoral Research Fellow at Microsoft Research India. He has worked on deterministic replay of multiprocessor virtual machine for his Ph.D. thesis. His recent work proposes a safe manual management scheme for safe languages which is remarkably faster than garbage collection. His current work focuses on building safe operating systems for IOT devices.',
      'faculty_College': 'PhD (2018), IIT-Delhi, India',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/piyuskedia.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/piyus',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907528"',
      'faculty_Office_Address': 'B-505 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'System security, safe languages, virtualization and dynamic/static techniques to build systems',
      'faculty_Teaching_Interests':
          'System security, safe languages, virtualization and dynamic/static techniques to build systems'
    },
    {
      'faculty_Name': 'Praveen Priyadarshi',
      'faculty_EmailId': 'praveen@iiitd.ac.in',
      'faculty_Department': 'SSH',
      'faculty_Position': 'Assistant Professor (SSH)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Dr. Praveen Priyadarshi completed his Ph.D. in Development Studies from London School of Economics and Political Science (LSE), London. His academic interest lies at the intersections of the categories of space, institutions and policy especially in the urban context. He brings these categories to bear upon his understanding of contemporary politics in India and the Global South. Before joining us, Praveen has been an Assistant Professor in the Department of Political Science, Zakir Husain Delhi College, Evening, University of Delhi (DU). His publications include papers in Economic and Political Weekly (EPW) and a co-edited book from Pearson Longman, titled Contemporary India: Economy, Society, Politics. He has been an Associate at the Crisis States Research Centre, LSE, and at the Developing Countries Research Centre (DCRC), University of Delhi. He was the Tata Ph.D. Fellow at the Asia Research Centre (ARC), at the London School of Economics.',
      'faculty_College':
          'Ph.D. London School of Economics and Political Science, London',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/praveen.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/praveen',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907359"',
      'faculty_Office_Address': 'A-203 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Distinctiveness of everyday political practices in new urban spaces',
      'faculty_Teaching_Interests':
          'Smart Cities,Urban Politics,Indian Democracy'
    },
    {
      'faculty_Name': 'Pravesh Biyani',
      'faculty_EmailId': 'praveshb@iiitd.ac.in',
      'faculty_Department': 'ECE',
      'faculty_Position': 'Associate Professor (ECE)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'TRUE\n',
      'faculty_Bio':
          'I was born in Raigarh, India and received my B.Tech from IIT Bombay in 2002 and MS from McMaster University in the year 2004. I have also worked at the Ikanos Communications while pursuing my Ph.D. at the IIT Delhi till early 2012. In the later 2012, I was a post- doctoral researcher at the University of Minnesota, Minneapolis with Prof. Tom Luo. I have won the INSPIRE Faculty award by the Govt. of India in 2012 and am currently an INSPIRE faculty at the IIIT Delhi. My research interests are physical layer wireless and wireline communications, optimization for signal processing and machine learning. Recently I have developed interest in applying ideas from Convex Optimization in solving problems in urban transportation, specially the bus route network design problem.',
      'faculty_College': '\nPh.D. (2012), IIT-Delhi',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/pravesh.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/praveshb',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907449"',
      'faculty_Office_Address': '\nA-604 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Optimisation for signal processing and communications,Machine learning, and transportation.',
      'faculty_Teaching_Interests':
          'Signal Processing,Optimisation,Communications.'
    },
    {
      'faculty_Name': 'Pushpendra Singh',
      'faculty_EmailId': 'psingh@iiitd.ac.in',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Professor (CSE)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Pushpendra Singh is a Professor at Indraprastha Institute of Information Technology (IIITD), New Delhi. He completed his Ph.D. in 2004 from Inria-Rennes, France in the area of mobile computing. He worked at Portsmouth University, Newcastle University, and Inria-Rocquencourt before IIITD. His primary research interest areas are mobile systems and applications, middleware, and ICT for Development. His work has been successfully transferred to Industry in the past leading to creation of start-ups and new products. His research is funded by DEiTY, ITRA, DST, DRDO, CEFIPRA etc. His work has been deployed in the field for various projects including in projects related to national schemes such as NRHM (National Rural Health Mission) and NREGS (National Rural Employment Guarantee Scheme). Pushpendra Singh has also been appointed Nodal Officer by Govt. of NCT, Delhi for running 181-Women-in-distress helpline. All the software for the helpline has been developed by the team of Pushpendra.',
      'faculty_College':
          'PhD (2004), Inria-Rennes, University de Rennes 1, France',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/puspendra.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/pushpendra',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907458"',
      'faculty_Office_Address': 'A-502 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Mobile Systems and Applications,Middleware,ICT for Development',
      'faculty_Teaching_Interests':
          'Operating Systems,Computer Networks,Mobile Computing.'
    },
    {
      'faculty_Name': 'Rajiv Raman',
      'faculty_EmailId': 'rajiv@iiitd.ac.in',
      'faculty_Department': 'CSE,Maths',
      'faculty_Position': 'Associate Professor (CSE, Maths)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'My primary area of research is algorithms. I am interested in the design and analysis of algorithms for problems in various domains such as scheduling, resource allocation, graph colouring and geometry. I also have an interest in the development of efficient practical heuristics for real-life problems. I obtained a PhD degree in Computer Science from the University of Iowa in 2007. Since then, I worked as a postdoctoral fellow at the Max-Planck institute for informatics in Germany, and at the centre for Discrete Mathematics and Applications at the University of Warwick. I also worked briefly at TCS Innovation labs before joining IIIT in 2012.',
      'faculty_College': 'PhD (2007), University of Iowa, USA',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/rajiv.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/rajiv',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907573"',
      'faculty_Office_Address': 'B-507 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Algorithms,Combinatorial Optimization,Graph Theory,discrete and computational geometry',
      'faculty_Teaching_Interests':
          'Algorithms,Discrete mathematics,Optimization,Graph theory'
    },
    {
      'faculty_Name': 'Rajiv Ratn Shah',
      'faculty_EmailId': 'rajivratn@iiitd.ac.in',
      'faculty_Department': 'CSE,HCD',
      'faculty_Position': 'Head (HCD), Assistant Professor (CSE, HCD)',
      'faculty_Affiliated_Centers_And_Labs':
          'Center for Design and New Media (Supported by Tata Consultancy Services, a TCS Foundation Initiative)',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Rajiv Ratn Shah received his Ph.D. in computer science from the National University of Singapore, Singapore. Prior completing his Ph.D., he received his M.Tech. and MCA degrees in computer applications from the Delhi Technological University, Delhi and Jawaharlal Nehru University, Delhi, respectively. He has also received his BSc in Mathematics (Honors) from the Banaras Hindu University, Varanasi. Dr Shah is the recipient of several awards, including the prestigious European Research Consortium for Informatics and Mathematics (ERCIM) Fellowship and runner-up in the Grand Challenge competition of ACM International Conference on Multimedia. He is involved in organizing and reviewing of many top-tier international conferences and journals. After joining IIITD in Dec 2016, he has spent 1 year as a Research Fellow in Living Analytics Research Center (LARC) at the Singapore Management University, Singapore.',
      'faculty_College':
          'PhD (2017), National University of Singapore, Singapore',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/ratn.jpg',
      'faculty_LinkedIn_Url': 'https://www.linkedin.com/in/rajivratn/',
      'faculty_Website_Url': 'https://iiitd.ac.in/rajivratn',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907495"',
      'faculty_Office_Address': 'A-409 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Multimodal semantic and sentiment analysis of user-generated social media content,NLP Speech ProcessingComputer VisionMultimodal Computing',
      'faculty_Teaching_Interests':
          'Deep learning based multimedia systems,Information Retrieval,HCI, Multimedia Content Analysis'
    },
    {
      'faculty_Name': 'Rakesh Chaturvedi',
      'faculty_EmailId': 'rakesh@iiitd.ac.in',
      'faculty_Department': 'SSH',
      'faculty_Position': 'Assistant Professor (SSH)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Rakesh Chaturvedi completed his Ph.D. in Economics from Pennsylvania State University in 2015. He uses mathematical modeling and analysis in his research. His recent and ongoing work aims to design good mechanisms for resource allocation problems. Some of his current areas of interest are problems in market design and game theory. Before his PhD, Rakesh obtained his Masters degree in Economics from Delhi School of Economics and his undergraduate degree in Mining Engineering from Institute of Technology at Banaras Hindu University. Before joining IIITD, Rakesh was a faculty at Indian Institute of Management Udaipur during 2015-2017 and an adjunct faculty at Delhi School of Economics during 2008-09',
      'faculty_College': 'Ph.D. (2015), Pennsylvania State University',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/rakeshc.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/rakesh',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907535"',
      'faculty_Office_Address': 'B-205 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests': 'Market Design,Game Theory,Microeconomics',
      'faculty_Teaching_Interests': 'Market Design,Game Theory,Microeconomics'
    },
    {
      'faculty_Name': 'Ram Krishna Ghosh',
      'faculty_EmailId': 'rkghosh@iiitd.ac.in',
      'faculty_Department': 'ECE',
      'faculty_Position': 'Assistant Professor (ECE)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          "Dr. Ram Krishna Ghosh obtained his Ph.D. from the Department of Electronic Systems Engineering, Indian Institute of Science, Bangalore in 2013. He has experience in computational nanoelectronics, particularly in the area of 'materials-devices co-design' of next-generation CMOS and beyond CMOS computing. He has worked as a post-doctoral fellow at the Pennsylvania State University and the University of Notre Dame, USA. He has been a DST Inspire Faculty at the Jawaharlal Nehru University, New Delhi, before joining IIIT-Delhi. He is the recipient of the Best Ph.D. thesis award (Tag Corporation Medal) from the Council of Indian Institute of Science, Bangalore. He is also a recipient of Inspire Faculty Award from DST and the Early Career Research Award from SERB.His current research interests include computational materials design (primarily, ab-initio Density Functional Theory and Molecular Dynamics simulations), quantum transport simulations, and multiscale modeling of emerging electronic, spintronic, and photovoltaic devices.",
      'faculty_College': 'Ph.D. (2013), Indian Institute of Science, Bangalore',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/rkghosh.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/rkghosh',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907367"',
      'faculty_Office_Address': '\nB-601 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Computational nanoelectronics, spintronics, quantum transport simulation, device modeling, materials modeling, and multiscale modeling',
      'faculty_Teaching_Interests':
          'Electronics, Semiconductor Device Physics, Nanoscale Devices, Advanced CMOS and beyond CMOS Devices, Quantum Materials and Devices, etc.'
    },
    {
      'faculty_Name': 'Ranjan Bose',
      'faculty_EmailId': 'bose@iiitd.ac.in',
      'faculty_Department': 'ECE',
      'faculty_Position': 'Director and Professor (ECE)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Ranjan Bose is the Director of the Institute. Prior to joining IIIT-Delhi, he was Microsoft Chair Professor in the Department of Electrical Engineering at IIT-Delhi. He has also served as the Head of Bharti School of Telecom Technology and Management and as the founding Head of Center of Excellence in Cyber Systems and Information Assurance at IIT-Delhi.He received his B.Tech. degree in Electrical Engineering from IIT Kanpur and M.S. and Ph.D. degrees in Electrical Engineering from University of Pennsylvania, Philadelphia, USA.He is the author of the book Information Theory, Coding and Cryptography (3rd Ed.). This book has an international edition and has been translated into Chinese and Korean. He is the national coordinator for the MHRD Mission Project on Virtual Labs, which enables students all over the country to perform laboratory experiments remotely. He has also contributed to the National Program on Technology Enhanced Learning (NPTEL) and the National Pedagogy Project. He has served on the editorial boards of IEEE Access and Computers & Security (Elsevier), and has been the Editor-in-Chief of IETE Journal of Education. He has also been on the Security Advisory Board of GSTN.He is the recipient of the URSI Young Scientist award, the Indian National Academy of Engineers (INAE) Young Engineers Award, the AICTE Career Award for Young Teachers, the BOYSCAST Fellowship and Dr. Vikram Sarabhai Research Award.He is Fellow of IET (UK) and Humboldt Fellow (Germany).',
      'faculty_College':
          'PhD (1995), University of Pennsylvania, Philadelphia, USA',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/rbose_0.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/bose',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907481"',
      'faculty_Office_Address': 'A-707 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Secure Communications,Coding Theory,5G Security,Wireless Security,Physical Layer Security and Broadband Wireless Access',
      'faculty_Teaching_Interests':
          'Information Theory,Coding Theory,Physical Layer Security,Wireless Communications'
    },
    {
      'faculty_Name': 'Ranjitha Prasad',
      'faculty_EmailId': 'nan',
      'faculty_Department': 'ECE',
      'faculty_Position': 'Assistant Professor (ECE)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Dr. Ranjitha Prasad obtained her Ph.D. from Indian Institute of Science in 2015. Her experience is in the general areas of signal processing, Bayesian statistics, and more recently, machine learning and deep neural networks. She has been a postdoctoral researcher at Nanyang Technological University and National University of Singapore, Singapore, and a scientist at TCS Innovation Labs, Delhi. She is the recipient of the Best Ph.D. thesis award (The Seshagiri Kaikini Medal) for 2014- 2015 from the Council of Indian Institute of Science, and the recipient of the Best Paper in the Communications Track at NCC 2014, held at IIT Kanpur.Her current research interests are: Causal Inference, Survival analysis, and sparsity in Bayesian neural networks.',
      'faculty_College':
          '\nPh.D. (2015), Indian Institute of Science, Banglore',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/ranjitha.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/ranjitha',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907357"',
      'faculty_Office_Address': '\nB-607 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Causal Inference,Survival analysis, and sparsity in Bayesian neural networks.',
      'faculty_Teaching_Interests':
          'Causal Inference,Survival analysis, and sparsity in Bayesian neural networks.'
    },
    {
      'faculty_Name': 'Richa Gupta',
      'faculty_EmailId': 'richa.gupta@iiitd.ac.in',
      'faculty_Department': 'HCD',
      'faculty_Position': 'Assistant Professor (HCD)',
      'faculty_Affiliated_Centers_And_Labs':
          'Center for Design and New Media (Supported by Tata Consultancy Services, a TCS Foundation Initiative)',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Dr. Richa Gupta completed Ph.D. from IIT Delhi in 2020. She holds a post-graduate degree in Industrial Design (M.Des.) from IDC, IIT Bombay (2013) and completed B.Tech. in Mechanical Engineering from IIIT Jabalpur (2011). She has done collaborative research at the School of Informatics and Computing, IUPU Indianapolis, USA (2017-18) and TU Darmstadt, Germany (2012). She has also worked as Project Scientist at AssisTech Labs, IIT Delhi where she contributed in design and development of several award winning translational research projects, namely SmartCane Device, DotBook (Braille Laptop for Blind), TacRead, OnBoard Bus Identification System, Accessible Graphics Design, and Multi-Modal Braille Learning Device. She is recipient of several prestigious fellowships namely, Stanford Ignite Global Innovation Fellowship (2015), Visvesvaraya PhD Fellowship (2015), JENESYS Fellowship (Indo-Japan Exchange Program, 2010). She was awarded the Chairman’s Silver Medal for Excellence in Academics at IIIT Jabalpur in 2011. Her current research interests are: Perceptual foundations of Design, Inclusive Design and Accessibility, Product Design & Modern Prototyping, Multi-modal Interaction/Experience Designa',
      'faculty_College': 'Ph.D. (2020), IIT-Delhi',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/richagupta.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/richagupta',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907368"',
      'faculty_Office_Address': 'A-406 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Perceptual foundations of Design,Inclusive Design and Accessibility,Metaverse,HCI,Interaction Design,Educational Technologies',
      'faculty_Teaching_Interests':
          'Product Design & Prototyping, Inclusive Design & Accessibility,Design for Special Needs,Fundamentals of Design,Interaction Design'
    },
    {
      'faculty_Name': 'Rinku Shah',
      'faculty_EmailId': 'rinku@iiitd.ac.in',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Associate Professor (CSE, ECE)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio': 'nan',
      'faculty_College': 'PhD (2021), IIT Bombay, India',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/rinku.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/rinku',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': 'nan',
      'faculty_Office_Address': 'nan',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests': 'nan',
      'faculty_Teaching_Interests': 'nan'
    },
    {
      'faculty_Name': 'Saket Anand',
      'faculty_EmailId': 'anands@iiitd.ac.in',
      'faculty_Department': 'ECE, CSE',
      'faculty_Position': 'Associate Professor (CSE, ECE)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio': 'nan',
      'faculty_College': 'PhD (2013), Rutgers University, USA',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/saket.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/anands',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': 'nan',
      'faculty_Office_Address': 'nan',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests': 'nan',
      'faculty_Teaching_Interests': 'nan'
    },
    {
      'faculty_Name': 'Sambuddho Chakravarty',
      'faculty_EmailId': 'sambuddho@iiitd.ac.in',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Associate Professor (CSE)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio': 'nan',
      'faculty_College': 'PhD (2014), Columbia University, USA',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/sambuddho.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/sambuddho',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': 'nan',
      'faculty_Office_Address': 'nan',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests': 'nan',
      'faculty_Teaching_Interests': 'nan'
    },
    {
      'faculty_Name': 'Samrith Ram',
      'faculty_EmailId': 'samrith@iiitd.ac.in',
      'faculty_Department': 'Math',
      'faculty_Position': 'Associate Professor (MATH)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio': 'nan',
      'faculty_College': 'nan',
      'faculty_Image_Url': '',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'nan',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': 'nan',
      'faculty_Office_Address': 'nan',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests': 'nan',
      'faculty_Teaching_Interests': 'nan'
    },
    {
      'faculty_Name': 'Sanat K Biswas',
      'faculty_EmailId': 'sanat@iiitd.ac.in',
      'faculty_Department': 'ECE',
      'faculty_Position': 'Assistant Professor (ECE)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio': 'nan',
      'faculty_College': 'nan',
      'faculty_Image_Url': '',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'nan',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': 'nan',
      'faculty_Office_Address': 'nan',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests': 'nan',
      'faculty_Teaching_Interests': 'nan'
    },
    {
      'faculty_Name': 'Sanjit Krishnan Kaul',
      'faculty_EmailId': 'skkaul@iiitd.ac.in',
      'faculty_Department': 'ECE',
      'faculty_Position': 'Associate Professor (ECE)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio': 'nan',
      'faculty_College': 'nan',
      'faculty_Image_Url': '',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'nan',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': 'nan',
      'faculty_Office_Address': 'nan',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests': 'nan',
      'faculty_Teaching_Interests': 'nan'
    },
    {
      'faculty_Name': 'Sankha S Basu',
      'faculty_EmailId': 'sankha@iiitd.ac.in',
      'faculty_Department': 'Math',
      'faculty_Position': 'Assistant Professor (Math)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio': 'nan',
      'faculty_College': 'nan',
      'faculty_Image_Url': '',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'nan',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': 'nan',
      'faculty_Office_Address': 'nan',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests': 'nan',
      'faculty_Teaching_Interests': 'nan'
    },
    {
      'faculty_Name': 'Sarthok Sircar',
      'faculty_EmailId': 'sarthok@iiitd.ac.in',
      'faculty_Department': 'Math',
      'faculty_Position': 'Associate Professor (Math)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio': 'nan',
      'faculty_College': 'nan',
      'faculty_Image_Url': '',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'nan',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': 'nan',
      'faculty_Office_Address': 'nan',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests': 'nan',
      'faculty_Teaching_Interests': 'nan'
    },
    {
      'faculty_Name': 'Satish Kumar Pandey',
      'faculty_EmailId': 'satish@iiitd.ac.in',
      'faculty_Department': 'Math',
      'faculty_Position': 'Assistant Professor (Math)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio': 'nan',
      'faculty_College': 'nan',
      'faculty_Image_Url': '',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'nan',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': 'nan',
      'faculty_Office_Address': 'nan',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests': 'nan',
      'faculty_Teaching_Interests': 'nan'
    },
    {
      'faculty_Name': 'Sayak Bhattacharya',
      'faculty_EmailId': 'sayak@iiitd.ac.in',
      'faculty_Department': 'ECE',
      'faculty_Position': 'Assistant Professor (ECE)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio': 'nan',
      'faculty_College': 'nan',
      'faculty_Image_Url': '',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'nan',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': 'nan',
      'faculty_Office_Address': 'nan',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests': 'nan',
      'faculty_Teaching_Interests': 'nan'
    },
    {
      'faculty_Name': 'Sayan Basu Roy',
      'faculty_EmailId': 'sayan@iiitd.ac.in',
      'faculty_Department': 'ECE',
      'faculty_Position': 'Assistant Professor (ECE)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio': 'nan',
      'faculty_College': 'nan',
      'faculty_Image_Url': '',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'nan',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': 'nan',
      'faculty_Office_Address': 'nan',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests': 'nan',
      'faculty_Teaching_Interests': 'nan'
    },
    {
      'faculty_Name': 'Shobha Sundar Ram',
      'faculty_EmailId': 'shobha@iiitd.ac.in',
      'faculty_Department': 'ECE',
      'faculty_Position': 'Associate Professor (ECE)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio': 'nan',
      'faculty_College': 'nan',
      'faculty_Image_Url': '',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'nan',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': 'nan',
      'faculty_Office_Address': 'nan',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests': 'nan',
      'faculty_Teaching_Interests': 'nan'
    },
    {
      'faculty_Name': 'Smriti Singh',
      'faculty_EmailId': 'smriti@iiitd.ac.in',
      'faculty_Department': 'SSH',
      'faculty_Position': 'Assistant Professor (SSH)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio': 'nan',
      'faculty_College': 'nan',
      'faculty_Image_Url': '',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'nan',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': 'nan',
      'faculty_Office_Address': 'nan',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests': 'nan',
      'faculty_Teaching_Interests': 'nan'
    },
    {
      'faculty_Name': 'Sneh Saurabh',
      'faculty_EmailId': 'sneh@iiitd.ac.in',
      'faculty_Department': 'ECE',
      'faculty_Position': 'Associate Professor (ECE)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio': 'nan',
      'faculty_College': 'nan',
      'faculty_Image_Url': '',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'nan',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': 'nan',
      'faculty_Office_Address': 'nan',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests': 'nan',
      'faculty_Teaching_Interests': 'nan'
    },
    {
      'faculty_Name': 'Sneha Chaubey',
      'faculty_EmailId': 'sneha@iiitd.ac.in',
      'faculty_Department': 'Math',
      'faculty_Position': 'Assistant Professor (Math)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio': 'nan',
      'faculty_College': 'nan',
      'faculty_Image_Url': '',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'nan',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': 'nan',
      'faculty_Office_Address': 'nan',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests': 'nan',
      'faculty_Teaching_Interests': 'nan'
    },
    {
      'faculty_Name': 'Sonia Baloni Ray',
      'faculty_EmailId': 'sonia@iiitd.ac.in',
      'faculty_Department': 'SSH',
      'faculty_Position': 'Assistant Professor (SSH)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio': 'nan',
      'faculty_College': 'nan',
      'faculty_Image_Url': '',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'nan',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': 'nan',
      'faculty_Office_Address': 'nan',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests': 'nan',
      'faculty_Teaching_Interests': 'nan'
    },
    {
      'faculty_Name': 'Souvik Dutta',
      'faculty_EmailId': 'souvik@iiitd.ac.in',
      'faculty_Department': 'SSH',
      'faculty_Position': 'Assistant Professor (SSH)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio': 'nan',
      'faculty_College': 'nan',
      'faculty_Image_Url': '',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'nan',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': 'nan',
      'faculty_Office_Address': 'nan',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests': 'nan',
      'faculty_Teaching_Interests': 'nan'
    },
    {
      'faculty_Name': 'Sriram K',
      'faculty_EmailId': 'sriramk@iiitd.ac.in',
      'faculty_Department': 'CB',
      'faculty_Position': 'Associate Professor (CB)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio': 'nan',
      'faculty_College': 'nan',
      'faculty_Image_Url': '',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'nan',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': 'nan',
      'faculty_Office_Address': 'nan',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests': 'nan',
      'faculty_Teaching_Interests': 'nan'
    },
    {
      'faculty_Name': 'Subhabrata Samajder',
      'faculty_EmailId': 'subhabrata@iiitd.ac.in',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Assistant Professor (CSE)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio': 'nan',
      'faculty_College': 'PhD (2017) Indian Statistical Institute, Kolkata',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/subhabrata.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/subhabrata',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': 'nan',
      'faculty_Office_Address': 'nan',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests': 'nan',
      'faculty_Teaching_Interests': 'nan'
    },
    {
      'faculty_Name': 'Subhashree Mohapatra',
      'faculty_EmailId': 'subhashree@iiitd.ac.in',
      'faculty_Department': 'Math',
      'faculty_Position': 'Assistant Professor (Math)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio': 'nan',
      'faculty_College': 'nan',
      'faculty_Image_Url': '',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'nan',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': 'nan',
      'faculty_Office_Address': 'nan',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests': 'nan',
      'faculty_Teaching_Interests': 'nan'
    },
    {
      'faculty_Name': 'Sujay Deb',
      'faculty_EmailId': 'sdeb@iiitd.ac.in',
      'faculty_Department': 'ECE, CSE',
      'faculty_Position': 'Professor (ECE, CSE)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio': 'nan',
      'faculty_College': 'PhD (2012), Washington State University, USA',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/sdeb.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/sdeb',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': 'nan',
      'faculty_Office_Address': 'nan',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests': 'nan',
      'faculty_Teaching_Interests': 'nan'
    },
    {
      'faculty_Name': 'Sumit J Darak',
      'faculty_EmailId': 'sumit@iiitd.ac.in',
      'faculty_Department': 'ECE',
      'faculty_Position': 'Associate Professor (ECE)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio': 'nan',
      'faculty_College': 'nan',
      'faculty_Image_Url': '',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'nan',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': 'nan',
      'faculty_Office_Address': 'nan',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests': 'nan',
      'faculty_Teaching_Interests': 'nan'
    },
    {
      'faculty_Name': 'Syamantak Das',
      'faculty_EmailId': 'syamantak@iiitd.ac.in',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Assistant Professor (CSE)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio': 'nan',
      'faculty_College': 'PhD (2015), IIT-Delhi, India',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/syamantak.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/syamantak',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': 'nan',
      'faculty_Office_Address': 'nan',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests': 'nan',
      'faculty_Teaching_Interests': 'nan'
    },
    {
      'faculty_Name': 'Tammam Tillo',
      'faculty_EmailId': 'tammam@iiitd.ac.in',
      'faculty_Department': 'ECE',
      'faculty_Position': 'Professor (ECE)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio': 'nan',
      'faculty_College': 'nan',
      'faculty_Image_Url': '',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'nan',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': 'nan',
      'faculty_Office_Address': 'nan',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests': 'nan',
      'faculty_Teaching_Interests': 'nan'
    },
    {
      'faculty_Name': 'Tanmoy Chakraborty',
      'faculty_EmailId': 'tanmoy@iiitd.ac.in',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Associate Professor (CSE)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio': 'nan',
      'faculty_College': 'PhD (2015), IIT Kharagpur, India',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/tanmoy.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/tanmoy',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': 'nan',
      'faculty_Office_Address': 'nan',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests': 'nan',
      'faculty_Teaching_Interests': 'nan'
    },
    {
      'faculty_Name': 'Tarini Shankar Ghosh',
      'faculty_EmailId': 'tarini.ghosh@iiitd.ac.in',
      'faculty_Department': 'CB',
      'faculty_Position': 'Assistant Professor (CB)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio': 'nan',
      'faculty_College': 'nan',
      'faculty_Image_Url': '',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'nan',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': 'nan',
      'faculty_Office_Address': 'nan',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests': 'nan',
      'faculty_Teaching_Interests': 'nan'
    },
    {
      'faculty_Name': 'Tavpritesh Sethi',
      'faculty_EmailId': 'tavpriteshsethi@iiitd.ac.in',
      'faculty_Department': 'CB',
      'faculty_Position': 'Associate Professor (CB)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio': 'nan',
      'faculty_College': 'nan',
      'faculty_Image_Url': '',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'nan',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': 'nan',
      'faculty_Office_Address': 'nan',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests': 'nan',
      'faculty_Teaching_Interests': 'nan'
    },
    {
      'faculty_Name': 'V. Raghava Mutharaju',
      'faculty_EmailId': 'raghava.mutharaju@iiitd.ac.in\n',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Assistant Professor (CSE)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio': 'nan',
      'faculty_College': 'PhD (2016), Wright State University, USA',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/raghavam.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/raghavam',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': 'nan',
      'faculty_Office_Address': 'nan',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests': 'nan',
      'faculty_Teaching_Interests': 'nan'
    },
    {
      'faculty_Name': 'Venkata Ratnadeep Suri',
      'faculty_EmailId': 'ratan.suri@iiitd.ac.in',
      'faculty_Department': 'SSH',
      'faculty_Position': 'Assistant Professor (SSH)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio': 'nan',
      'faculty_College': 'nan',
      'faculty_Image_Url': '',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'nan',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': 'nan',
      'faculty_Office_Address': 'nan',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests': 'nan',
      'faculty_Teaching_Interests': 'nan'
    },
    {
      'faculty_Name': 'Vibhor Kumar',
      'faculty_EmailId': 'vibhor@iiitd.ac.in',
      'faculty_Department': 'CB',
      'faculty_Position': 'Associate Professor (CB)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio': 'nan',
      'faculty_College': 'nan',
      'faculty_Image_Url': '',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'nan',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': 'nan',
      'faculty_Office_Address': 'nan',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests': 'nan',
      'faculty_Teaching_Interests': 'nan'
    },
    {
      'faculty_Name': 'Vikram Goyal',
      'faculty_EmailId': 'vikram@iiitd.ac.in',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Professor (CSE)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio': 'nan',
      'faculty_College': 'PhD (2009), IIT Delhi, India',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/vikram.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/vikram',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': 'nan',
      'faculty_Office_Address': 'nan',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests': 'nan',
      'faculty_Teaching_Interests': 'nan'
    },
    {
      'faculty_Name': 'Vinayak Abrol',
      'faculty_EmailId': 'abrol@iiitd.ac.in',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Assistant Professor (CSE)',
      'faculty_Affiliated_Centers_And_Labs': 'Cross-Caps',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Prior to this he held Oxford-Emirates data science fellowship at Mathematical Institute, University of Oxford (10/2018-12/2020), position of Academic Advisor at Kellogg college Oxford (7/2019-12/2020) and SNSF funded postdoctoral position at IDIAP research Institute, Switzerland (2/2018-10/2018). He received his TCS Innovation Labs funded Ph.D from School of Computing and Electrical engineering, IIT Mandi, India in 2018; following M.E and B.E in electronics and communication engineering from Panjab University Chandigarh, India in 2013 and 2011, respectively. His research focuses on the design, and analysis of numerical algorithms for information inspired applications, which is multi-disciplinary and lies at an intersection of Engineering, Maths and Computer Science. On the theoretical front he is currently working on developing theories of deep learning using tools from random matrix theory, and information theory, where as on the applied front his research interest is in area of speech/audio analytics on problem such as acoustic modelling and coding, voice biometrics, pathological speech and audio categorization. His research has been disseminated in several internationally reputed journals and conferences, including JASA, IEEE TASLP/TMM, Elsevier Speech Communication/CSL/PRL, ICML, NIPS, INTERSPEECH, and ICASSP. Network: Infosys Centre for AI',
      'faculty_College': 'PhD (2018), IIT Mandi, India',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/vabrol.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/vabrol',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '"011-26907543"',
      'faculty_Office_Address': 'B-409 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Acoustic modelling and coding ,Voice biometrics, Pathological speech and audio categorization',
      'faculty_Teaching_Interests':
          'Theories of Deep Learning, Machine Learning,Speech and Audio Processing'
    },
    {
      'faculty_Name': 'Vivek Bohara',
      'faculty_EmailId': 'vivek.b@iiitd.ac.in',
      'faculty_Department': 'ECE',
      'faculty_Position': 'Head, Professor (ECE)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio': 'nan',
      'faculty_College': 'nan',
      'faculty_Image_Url': '',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'nan',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': 'nan',
      'faculty_Office_Address': 'nan',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests': 'nan',
      'faculty_Teaching_Interests': 'nan'
    },
    {
      'faculty_Name': 'Vivek Kumar',
      'faculty_EmailId': 'vivekk@iiitd.ac.in',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Assistant Professor (CSE)',
      'faculty_Affiliated_Centers_And_Labs': 'nan',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Vivek Kumar works in the area of High Performance Computing. He received his Ph.D. from Australian National University and B.E. from Visvesvaraya Technological University. His Ph.D. research focused on using managed runtime techniques for improving the performance and productivity of parallel programming on multicore architectures. Prior to Ph.D., he has worked for nearly 6 years in research and development positions in HPC areas at technology firms such as CDAC R&D and IBM Systems and Technology Labs. After completing his Ph.D., he worked for nearly 3 years as a Research Scientist at Rice University.',
      'faculty_College':
          'PhD (2014), Research School of Computer Science, Australian National University',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/vivekk.jpg',
      'faculty_LinkedIn_Url': 'nan',
      'faculty_Website_Url': 'https://iiitd.ac.in/vivekk',
      'faculty_Mobile_Messaging_Token_Id': 'nan',
      'faculty_Mobile_Number': '011-26907441',
      'faculty_Office_Address': 'B-506 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Research_Interests':
          'Parallel programming models and runtime systems.',
      'faculty_Teaching_Interests':
          'Parallel programming models and runtime systems.'
    }
  ];

  List<FacultyServerInformation> facultiesList = [
    // FacultyServerInformation(
    //   faculty_Unique_Id: "1",
    //   faculty_Name: "Henansh",
    //   faculty_Position: "CEO",
    //   faculty_EmailId: "temp@gmail.com",
    //   faculty_Gender: "Male",
    //   faculty_Bio: "BIO",
    //   faculty_Image_Url: "assets/images/icons/profile.png",
    //   faculty_LinkedIn_Url: "assets/images/icons/profile.png",
    //   faculty_Website_Url: "assets/images/icons/profile.png",
    //   faculty_Office_Address: "addr",
    //   faculty_Office_Latitude: 12.5,
    //   faculty_Office_Longitude: 10.2,
    //   faculty_Mobile_Messaging_Token_Id: 'dsafasdfsa',
    //   faculty_Affiliated_Centers_And_Labs:
    //       'fasdf, dsfasd, fsdfsdf, dasfasd, fadsfsad',
    //   faculty_College: 'IIIT Delhi',
    //   faculty_Mobile_Number: '123456789',
    //   faculty_Research_Interests: 'd d d d d d',
    // ),
  ];

  Future<FacultyServerInformation> getFacultyDetails(
      String facultyDatabaseUniqueId) async {
    late FacultyServerInformation facultyInfo;

    await FirebaseFirestore.instance
        .collection('FacultiesInformationList')
        // .doc(facultyDatabaseUniqueId)
        .doc(qrIdentifierMap[facultyDatabaseUniqueId])
        .get()
        .then((DocumentSnapshot ds) {
      facultyInfo = new FacultyServerInformation(
        faculty_Unique_Id: ds.get('faculty_Unique_Id').toString(),
        faculty_Authorization:
            ds.get('faculty_Authorization').toString() == 'true',
        faculty_Mobile_Messaging_Token_Id:
            ds.get('faculty_Mobile_Messaging_Token_Id').toString(),
        faculty_Name: ds.get('faculty_Name').toString(),
        faculty_Position: ds.get('faculty_Position').toString(),
        faculty_College: ds.get('faculty_College').toString(),
        faculty_Department: ds.get('faculty_Department').toString(),
        faculty_Mobile_Number: ds.get('faculty_Mobile_Number').toString(),
        faculty_Teaching_Interests:
            ds.get('faculty_Teaching_Interests').toString(),
        faculty_Research_Interests:
            ds.get('faculty_Research_Interests').toString(),
        faculty_Affiliated_Centers_And_Labs:
            ds.get('faculty_Affiliated_Centers_And_Labs').toString(),
        faculty_EmailId: ds.get('faculty_EmailId').toString(),
        faculty_Gender: ds.get('faculty_Gender').toString(),
        faculty_Bio: ds.get('faculty_Bio').toString(),
        faculty_Image_Url: ds.get('faculty_Image_Url').toString(),
        faculty_LinkedIn_Url: ds.get('faculty_LinkedIn_Url').toString(),
        faculty_Website_Url: ds.get('faculty_Website_Url').toString(),
        faculty_Office_Navigation_Url:
            ds.get('faculty_Office_Navigation_Url').toString(),
        faculty_Office_Address: ds.get('faculty_Office_Address').toString(),
        faculty_Office_Longitude:
            checkIfDouble(ds.get('faculty_Office_Longitude').toString()),
        faculty_Office_Latitude:
            checkIfDouble(ds.get('faculty_Office_Latitude').toString()),
      );
    });

    notifyListeners();
    return facultyInfo;
  }



  Future<void> facultyQRCodeNavigator(
    BuildContext context,
    String facultyDatabaseUniqueId,
  ) async {
    late FacultyServerInformation facultyInfo;

    await FirebaseFirestore.instance
        .collection('FacultiesInformationList')
        // .doc(facultyDatabaseUniqueId)
        .doc(qrIdentifierMap[facultyDatabaseUniqueId])
        .get()
        .then((DocumentSnapshot ds) {
      facultyInfo = new FacultyServerInformation(
        faculty_Unique_Id: ds.get('faculty_Unique_Id').toString(),
        faculty_Authorization:
            ds.get('faculty_Authorization').toString() == 'true',
        faculty_Mobile_Messaging_Token_Id:
            ds.get('faculty_Mobile_Messaging_Token_Id').toString(),
        faculty_Name: ds.get('faculty_Name').toString(),
        faculty_Position: ds.get('faculty_Position').toString(),
        faculty_College: ds.get('faculty_College').toString(),
        faculty_Department: ds.get('faculty_Department').toString(),
        faculty_Mobile_Number: ds.get('faculty_Mobile_Number').toString(),
        faculty_Teaching_Interests:
            ds.get('faculty_Teaching_Interests').toString(),
        faculty_Research_Interests:
            ds.get('faculty_Research_Interests').toString(),
        faculty_Affiliated_Centers_And_Labs:
            ds.get('faculty_Affiliated_Centers_And_Labs').toString(),
        faculty_EmailId: ds.get('faculty_EmailId').toString(),
        faculty_Gender: ds.get('faculty_Gender').toString(),
        faculty_Bio: ds.get('faculty_Bio').toString(),
        faculty_Image_Url: ds.get('faculty_Image_Url').toString(),
        faculty_LinkedIn_Url: ds.get('faculty_LinkedIn_Url').toString(),
        faculty_Website_Url: ds.get('faculty_Website_Url').toString(),
        faculty_Office_Navigation_Url:
            ds.get('faculty_Office_Navigation_Url').toString(),
        faculty_Office_Address: ds.get('faculty_Office_Address').toString(),
        faculty_Office_Longitude:
            checkIfDouble(ds.get('faculty_Office_Longitude').toString()),
        faculty_Office_Latitude:
            checkIfDouble(ds.get('faculty_Office_Latitude').toString()),
      );
    });

    // Navigator.of(context).pushAndRemoveUntil(
    //   MaterialPageRoute(
    //     builder: (context) => FacultyDetailScreen(
    //       facultyDetails: facultyInfo,
    //     ),
    //   ),
    //   (route) => false,
    // );
  }

  Map<String, String> qrIdentifierMap ={
    "/subramanyam": "subramanyam@iiitd.ac.in",
    "/aasim": "aasim@iiitd.ac.in",
    "/abhijit": "abhijit@iiitd.ac.in",
    "/aman": "aman@iiitd.ac.in",
    "/anand": "anand@iiitd.ac.in",
    "/angshul": "angshul@iiitd.ac.in",
    "/anmol": "anmol@iiitd.ac.in",
    "/anubha": "anubha@iiitd.ac.in",
    "/anujg": "anujg@iiitd.ac.in",
    "/anuradha": "anuradha@iiitd.ac.in",
    "/arani": "arani@iiitd.ac.in",
    "/arjun": "arjun@iiitd.ac.in",
    "/arunb": "arunb@iiitd.ac.in",
    "/ashishk": "ashishk@iiitd.ac.in",
    "/bapi": "bapi@iiitd.ac.in",
    "/chanekar": "chanekar@iiitd.ac.in",
    "/dbera": "dbera@iiitd.ac.in",
    "/debarka": "debarka@iiitd.ac.in",
    "/debika": "debika@iiitd.ac.in",
    "/dhruv": "dhruv.kumar@iiitd.ac.in",
    "/diptapriyo": "diptapriyo@iiitd.ac.in",
    "/donghoon": "donghoon@iiitd.ac.in",
    "/raghava": "raghava@iiitd.ac.in",
    "/bagler": "bagler@iiitd.ac.in",
    "/gauravahuja": "gauravahuja@iiitd.ac.in",
    "/gaurava": "gauravahuja@iiitd.ac.in",
    "/gayatri": "gayatri@iiitd.ac.in",
    "/jainendra": "jainendra@iiitd.ac.in",
    "/jaspreet": "jaspreet@iiitd.ac.in",
    "/kaushik": "kaushik@iiitd.ac.in",
    "/kanjilal": "kanjilal@iiitd.ac.in",
    "/koteswar": "koteswar@iiitd.ac.in",
    "/manohark": "manohark@iiitd.ac.in",
    "/manuj": "manuj@iiitd.ac.in",
    "/shad": "shad@iiitd.ac.in",
    "/monika": "monika@iiitd.ac.in",
    "/mrinmoy": "mrinmoy@iiitd.ac.in",
    "/mukesh": "mukesh@iiitd.ac.in",
    "/mukulika": "mukulika@iiitd.ac.in",
    "/arulmurugan": "arulmurugan@iiitd.ac.in",
    "/nishad": "nishad@iiitd.ac.in",
    "/ojaswa": "ojaswa@iiitd.ac.in",
    "/jalote": "jalote@iiitd.ac.in",
    "/paro": "paro@iiitd.ac.in",
    "/piyus": "piyus@iiitd.ac.in",
    "/praveen": "praveen@iiitd.ac.in",
    "/praveshb": "praveshb@iiitd.ac.in",
    "/pushpendra": "pushpendra@iiitd.ac.in",
    "/rajiv": "rajiv@iiitd.ac.in",
    "/rajivratn": "rajivratn@iiitd.ac.in",
    "/rakesh": "rakesh@iiitd.ac.in",
    "/rkghosh": "rkghosh@iiitd.ac.in",
    "/bose": "bose@iiitd.ac.in",
    "/ranjitha": "ranjitha@iiitd.ac.in",
    "/richagupta": "richagupta@iiitd.ac.in",
    "/rinku": "rinku@iiitd.ac.in",
    "/anands": "anands@iiitd.ac.in",
    "/sambuddho": "sambuddho@iiitd.ac.in",
    "/samrithram": "samrithram@iiitd.ac.in",
    "/sanat": "sanat@iiitd.ac.in",
    "/skkaul": "skkaul@iiitd.ac.in",
    "/sankha": "sankha@iiitd.ac.in",
    "/sarthok": "sarthok@iiitd.ac.in",
    "/satish": "satish@iiitd.ac.in",
    "/sayak": "sayak@iiitd.ac.in",
    "/sayan": "sayan@iiitd.ac.in",
    "/shobha": "shobha@iiitd.ac.in",
    "/smriti": "smriti@iiitd.ac.in",
    "/sneh": "sneh@iiitd.ac.in",
    "/sneha": "sneha@iiitd.ac.in",
    "/sonia": "sonia@iiitd.ac.in",
    "/souvik": "souvik@iiitd.ac.in",
    "/sriram": "sriram@iiitd.ac.in",
    "/subhabrata": "subhabrata@iiitd.ac.in",
    "/subhashreem": "subhashreem@iiitd.ac.in",
    "/sdeb": "sdeb@iiitd.ac.in",
    "/sumit": "sumit@iiitd.ac.in",
    "/syamantak": "syamantak@iiitd.ac.in",
    "/tammam": "tammam@iiitd.ac.in",
    "/tanmoy": "tanmoy@iiitd.ac.in",
    "/tarini": "tarini@iiitd.ac.in",
    "/tavpritesh": "tavpritesh@iiitd.ac.in",
    "/raghavam": "raghavam@iiitd.ac.in",
    "/ratan": "ratan@iiitd.ac.in",
    "/vibhork": "vibhork@iiitd.ac.in",
    "/vikram": "vikram@iiitd.ac.in",
    "/vabrol": "vabrol@iiitd.ac.in",
    "/vivek": "vivek@iiitd.ac.in",
    "/vivekk": "vivekk@iiitd.ac.in"
  };

  Future<void> fetchCollegeFaculties(
    BuildContext context,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference facultiesRef =
        db.collection("FacultiesInformationList");

    List<FacultyServerInformation> listOfFaculties = [];
    try {
      await facultiesRef.get().then(
        (ds) async {
          ds.docs.forEach(
            (facultyDetails) async {
              final facultyMap = facultyDetails.data() as Map<String, dynamic>;

              FacultyServerInformation facultyInfo = FacultyServerInformation(
                faculty_Unique_Id: facultyMap["faculty_Unique_Id"],
                faculty_Name: facultyMap["faculty_Name"],
                faculty_Position: facultyMap["faculty_Position"],
                faculty_EmailId: facultyMap["faculty_EmailId"],
                faculty_Gender: facultyMap["faculty_Gender"],
                faculty_Bio: facultyMap["faculty_Bio"],
                faculty_Teaching_Interests:
                    facultyMap["faculty_Teaching_Interests"],
                faculty_Authorization:
                    facultyMap["faculty_Authorization"] == "true",
                faculty_Image_Url: facultyMap["faculty_Image_Url"],
                faculty_LinkedIn_Url: facultyMap["faculty_LinkedIn_Url"],
                faculty_Website_Url: facultyMap["faculty_Website_Url"],
                faculty_Office_Navigation_Url:
                    facultyMap["faculty_Office_Navigation_Url"],
                faculty_Office_Address: facultyMap["faculty_Office_Address"],
                faculty_Office_Longitude:
                    checkIfDouble(facultyMap["faculty_Office_Longitude"]),
                faculty_Office_Latitude:
                    checkIfDouble(facultyMap["faculty_Office_Latitude"]),
                faculty_Mobile_Messaging_Token_Id:
                    facultyMap['faculty_Mobile_Messaging_Token_Id'],
                faculty_Affiliated_Centers_And_Labs:
                    facultyMap['faculty_Affiliated_Centers_And_Labs'],
                faculty_College: facultyMap['faculty_College'],
                faculty_Mobile_Number: facultyMap['faculty_Mobile_Number'],
                faculty_Research_Interests:
                    facultyMap['faculty_Research_Interests'],
                faculty_Department: facultyMap['faculty_Department'],
              );

              listOfFaculties.add(facultyInfo);
            },
          );
        },
      );

      facultiesList = listOfFaculties;
      notifyListeners();
    } catch (errorVal) {
      print(errorVal);
    }

    // return listOfFaculties;
  }

  Future<void> insertListOfFaculties(BuildContext context) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef = db.collection("FacultiesInformationList");

    try {
      dataList.forEach((element) async {
        print(element['faculty_EmailId']);
        await usersRef.doc(element['faculty_EmailId']).set(
          {
            "faculty_Unique_Id": "",
            "faculty_Authorization": "true",
            "faculty_Mobile_Messaging_Token_Id": "",
            "faculty_Google_Auth_Token_Id": "",
            "faculty_Name": element['faculty_Name'],
            "faculty_Position": element['faculty_Position'],
            "faculty_College": element['faculty_College'],
            "faculty_Teaching_Interests": element['faculty_Teaching_Interests'],
            "faculty_Department": element['faculty_Department'],
            "faculty_Mobile_Number": element['faculty_Mobile_Number'],
            "faculty_Research_Interests": element['faculty_Research_Interests'],
            "faculty_Affiliated_Centers_And_Labs":
                element['faculty_Affiliated_Centers_And_Labs'],
            "faculty_EmailId": element['faculty_EmailId'],
            "faculty_Gender": "",
            "faculty_Bio": element['faculty_Bio'],
            "faculty_Image_Url": element['faculty_Image_Url'],
            "faculty_LinkedIn_Url": element['faculty_LinkedIn_Url'],
            "faculty_Website_Url": element['faculty_Website_Url'],
            "faculty_Office_Navigation_Url": "",
            "faculty_Office_Address": element['faculty_Office_Address'],
            "faculty_Office_Longitude": element['faculty_Office_Longitude'],
            "faculty_Office_Latitude": element['faculty_Office_Latitude'],
          },
        );
      });
    } catch (errorVal) {
      print(errorVal);
    }
  }

  double checkIfDouble(String val) {
    if (double.tryParse(val).toString() != 'null') {
      return double.parse(val);
    } else if (val == 'null' ||
        val == '' ||
        int.tryParse(val).toString() == 'null' ||
        double.tryParse(val).toString() == 'null') {
      return 0.0;
    } else {
      return double.parse(val);
    }
  }
}
