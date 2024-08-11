<script setup lang="ts">

import Heading2 from "@/Pages/CambridgeBrainPacer/Heading2.vue";
import Heading3 from "@/Pages/CambridgeBrainPacer/Heading3.vue";
import HeroAnimation from "@/Pages/CambridgeBrainPacer/HeroAnimation.vue";
import { Head } from '@inertiajs/vue3'

defineProps<{}>();

type TeamMember = {
    name: string;
    photoUrl?: string;
    credentials: string[];
    titles: string[];
    positions: string[];
    department: string;
    organization: string;
}

const teamMembers: TeamMember[] = [
    {
        "name": "Valerie Voon",
        "credentials": ["MD", "PhD"],
        "photoUrl": "https://i1.rgstatic.net/ii/profile.image/273577370976271-1442237336591_Q128/Valerie-Voon.jpg",
        "titles": [],
        "positions": [
            "Professor, University of Cambridge",
            "Distinguished Professor, Fudan University",
            "Honorary Consultant Psychiatrist"
        ],
        "department": "Chief Investigator",
        "organization": "Cambridge"
    },
    {
        "name": "David Christmas",
        "credentials": ["MBChB", "MD", "MRCPsych"],
        "photoUrl": "https://www.emedevents.com/_next/image?url=https%3A%2F%2Fstatic.emedevents.com%2Fuploads%2Fspeakers%2F200%2F0c93b7f8e5f8151b8bb226d3ee560a28.png&w=128&q=70",
        "titles": [],
        "positions": ["Honorary Consultant Psychiatrist"],
        "department": "Neuropsychiatry",
        "organization": "Cambridge"
    },
    {
        "name": "David Okai",
        "credentials": ["MD", "MRCPsych"],
        "photoUrl": "https://optimise2.assets-servd.host/mushy-parakeet/production/assets/images/Profile-images/david-okai.png?w=768&h=768&q=80&auto=format&fit=min&crop=focalpoint&fp-x=0.4361&fp-y=0.3931&dm=1694450280&s=34aed4dadbb594cae01cd35e78378c5f",
        "titles": [],
        "positions": ["Consultant Neuropsychiatrist"],
        "department": "Neuropsychiatry",
        "organization": "King's College"
    },
    {
        "name": "Jonathon Wood",
        "credentials": ["MD"],
        "titles": [],
        "positions": ["Addiction Psychiatrist"],
        "department": "Addiction Psychiatry Consultants",
        "organization": "Cambridge"
    },
    {
        "name": "John Strang",
        "photoUrl": "https://www.lisbonaddictions.eu/lisbon-addictions-2019/sites/lisbonaddictions.eu.lisbon-addictions-2019/files/styles/large/public/JohnStrang-1-small-cropped-400px.jpg?itok=Xnx3Tr8h",
        "credentials": ["MD", "PhD"],
        "titles": ["Professor", "Sir"],
        "positions": [
            "Head of Addictions Medicine Department, KCL",
            "Leader of the Addictions Clinical Academic Group"
        ],
        "department": "Addiction Psychiatry Consultants",
        "organization": "King's College"
    },
    {
        "name": "Emily Finch",
        "photoUrl": "https://www.kcl.ac.uk/newimages/person-profile/2021/emily-finch.x16c6691b.jpg?w=202&h=230&crop=160,160,26,22&f=webp",
        "credentials": ["MD"],
        "titles": [],
        "positions": [
            "Addiction Psychiatrist at South London and Maudsley",
            "Clinical Director of Addictions Clinical Academic Group"
        ],
        "department": "Addiction Psychiatry Consultants",
        "organization": "King's College"
    },
    {
        "name": "Michael Kelleher",
        "photoUrl": "https://iotodeducation.com/wp-content/uploads/2015/09/Mike-Kelleher.png",
        "credentials": ["MD"],
        "titles": [],
        "positions": ["Consultant Addictions Psychiatry at South London and Maudsley NHS Trust"],
        "department": "Addiction Psychiatry Consultants",
        "organization": "King's College"
    },
    {
        "name": "Nicola Kalk",
        "credentials": ["MD"],
        "photoUrl": "https://cdn.theconversation.com/avatars/899364/width238/image-20191129-156095-91mllf.jpg",
        "titles": [],
        "positions": ["Consultant Addictions Psychiatry at South London and Maudsley NHS Trust"],
        "department": "Addiction Psychiatry Consultants",
        "organization": "King's College"
    },
    {
        "name": "Soraya Mayet",
        "photoUrl": "https://pbs.twimg.com/media/GOK8P1rXYAAwlAi?format=png&name=360x360",
        "credentials": ["MD", "PhD"],
        "titles": [],
        "positions": ["Addiction Psychiatrist"],
        "department": "Addiction Psychiatry Consultants",
        "organization": "Humber NHS Foundation Trust"
    },
    {
        "name": "Rob Morris",
        "credentials": ["MD"],
        "titles": [],
        "positions": ["Consultant Neurosurgeon, Addenbrooke's Hospital"],
        "department": "Neurosurgery",
        "organization": "Cambridge"
    },
    {
        "name": "Peter Hutchinson",
        "credentials": ["MD", "PhD"],
        "titles": [],
        "positions": [
            "NIHR Research Professor at the Department of Clinical Neurosciences, University of Cambridge",
            "Consultant Neurosurgeon, Addenbrooke's Hospital"
        ],
        "department": "Neurosurgery",
        "organization": "Cambridge"
    },
    {
        "name": "Keyoumars Ashkan",
        "credentials": ["MD"],
        "titles": [],
        "positions": [
            "Professor of Neurosurgery",
            "Lead Clinician for Neuro-oncology",
            "Chair of King's Neurosciences Trial Unit"
        ],
        "department": "Neurosurgery",
        "organization": "King's College"
    },
    {
        "name": "Tim Denison",
        "credentials": ["PhD"],
        "titles": [],
        "positions": ["Joint professor of Engineering Science and Clinical Neurosciences"],
        "department": "Neuroengineering",
        "organization": "Oxford"
    },
    {
        "name": "Huiling Tan",
        "credentials": ["PhD"],
        "titles": [],
        "positions": ["Professor of Human Electrophysiology and Neuromodulation"],
        "department": "Neuroengineering",
        "organization": "Oxford"
    },
    {
        "name": "Samantha Sallie",
        "credentials": ["PhD"],
        "titles": [],
        "positions": [
            "Clinical Trials Coordinator",
            "Postdoctoral Scientist"
        ],
        "department": "Research Staff for Brain-PACER",
        "organization": "Cambridge"
    },
    {
        "name": "Luis Manssuer",
        "credentials": ["PhD"],
        "titles": [],
        "positions": ["Postdoctoral Scientist"],
        "department": "Research Staff for Brain-PACER",
        "organization": "Cambridge"
    },
    {
        "name": "Federica Magnabosco",
        "credentials": ["PhD"],
        "titles": [],
        "positions": ["Postdoctoral Scientist"],
        "department": "Research Staff for Brain-PACER",
        "organization": "Cambridge"
    },
    {
        "name": "Qiong Ding",
        "credentials": ["MS"],
        "titles": [],
        "positions": ["Research Assistant"],
        "department": "Research Staff for Brain-PACER",
        "organization": "Cambridge"
    },
    {
        "name": "Ilona Myllyneimi",
        "credentials": ["MA"],
        "titles": [],
        "positions": ["Research Assistant"],
        "department": "Research Staff for Brain-PACER",
        "organization": "Cambridge"
    },
    {
        "name": "Oliver Knight",
        "credentials": [],
        "titles": [],
        "positions": ["Research Assistant"],
        "department": "Research Staff for Brain-PACER",
        "organization": "Cambridge"
    }
]
</script>

<template>
    <Head>
        <title>Brain-PACER</title>
        <meta name="description" content="Deep Brain Stimulation for Addiction Treatment">
    </Head>
    <div class="w-full flex flex-row justify-center bg-slate-50 text-slate-500 text-lg px-2 leading-loose">
        <div class="max-w-[60rem] flex flex-col gap-4 mt-6 lg:mt-20 z-10">
            <div class="grid grid-cols-1 lg:grid-cols-2">
                <div class="h-full flex flex-col justify-center lg:h-[30rem]">
                    <h1 class="text-4xl lg:text-6xl font-bold text-slate-600 tracking-tighter z-10">Brain-PACER</h1>
                    <div class="tracking-tight leading-snug text-slate-400 lg:text-slate-600">Deep Brain Stimulation for Addiction Treatment</div>
                </div>
                <div class="flex flex-col justify-end relative items-center">
                    <img
                        src="/assets/images/brain1.png"
                        height="433" width="576"/>
                    <HeroAnimation/>
                </div>
            </div>

            <p>Welcome to Brain-PACER: Brain Pacemaker Addiction Control to End Relapse study. This is a multicentre
                research
                study using deep brain stimulation (DBS) to treat severe alcohol or opioid addiction.
            </p>
            <p>DBS is safe, well-tolerated and effective for Parkinson’s disease and obsessive compulsive disorder. It
                has been
                approved by the FDA and CE-marked since 1997 for neurological disorders. Here we are using DBS for
                refractory
                addiction to treat craving and relapse. The study is a collaboration between the University of
                Cambridge, Kings
                College London and the University of Oxford.</p>
            <p>We are recruiting patients for the study.
            </p>
            <Heading2>Study Overview</Heading2>
            <Heading3>Objective</Heading3>
            <p>The primary aim of the Brain-PACER study is to explore the effects of DBS to treat alcohol and opioid
                addiction,
                providing new hope for individuals struggling with severe addictions. Our mission is threefold: to
                develop
                effective treatments for addiction, to understand the brain mechanisms that drive addiction, and to
                enhance the
                quality of life for individuals impacted by these disorders.
            </p>
            <Heading3>Importance</Heading3>
            <p>Addiction is a major public health issue. It is a significant challenge worldwide, impacting millions of
                lives.
                DBS, a well-established and FDA-approved treatment for conditions like Parkinson’s disease (1997),
                dystonia
                (2003), and severe OCD (2009), it is now being explored as a method for addiction treatment. Several
                small
                studies of DBS in addictions shows potential efficacy and safety. Our study aims to provide robust
                evidence for
                the efficacy of DBS in treating refractory addictions, potentially transforming therapeutic approaches
                and
                improving patient outcomes.
            </p>
            <p>What sets Brain-PACER apart is our commitment to leveraging the latest advancements in neurotechnology to
                develop
                real-time adaptive therapies for addiction. Our comprehensive study aims to track physiological signals
                to
                predict when cravings occur, allowing us to dynamically adjust DBS parameters. This approach can offer
                personalised and highly effective treatment options for individuals battling addiction, especially those
                who
                have not found relief with other therapies.
            </p>
            <Heading2>Our Approach</Heading2>
            <p>Addictions can be broadly thought of as an imbalance of an accelerator – motivation and drive underlying
                addiction rewards, and impaired braking – decision making, control and flexibility. The Brain-PACER
                study
                employs DBS stimulation to address this imbalance by delivering precise electrical stimulation to brain
                regions
                to regulate the neural circuits responsible for addictive behaviours.
            </p>
            <Heading2>Target Areas for Brain-PACER DBS</Heading2>

            <ul>
                <li><span class="font-bold">Nucleus Accumbens:</span> This region is crucial for motivation, processing
                    rewards and reinforcing behaviors. By modulating its activity, we aim to reduce the urge for
                    repeated
                    alcohol and drug use. This modulation can alter dopamine signalling, essential in the reward
                    pathway,
                    thereby helping to reduce cravings.
                </li>
                <li><span class="font-bold">Ventral Internal Capsule:</span> This area contains pathways that connect
                    different parts of the brain involved in decision making and emotion. Stimulation here helps
                    regulate
                    decision-making and impulse control by linking the prefrontal cortex, responsible for higher-order
                    executive functions, with deeper brain structures involved in reward. Stimulation here addresses the
                    underlying neural mechanisms of addiction by improving impulse control and decision-making
                    processes.
                </li>
            </ul>

            <p>Stimulating these two areas aims to reduce cravings and improve control over addictive behaviours by
                modulating
                the brain circuits involved in reward, motivation and decision making.

            </p>
            <Heading2>How DBS Works</Heading2>
            <p>DBS is a neurosurgical treatment that involves implanting a slender electrode in the brain and a
                pacemaker under
                general anaesthesia. These electrodes deliver electrical impulses to modulate neural activity, which can
                help
                alleviate symptoms of various neurological and psychiatric disorders. DBS has been safely and
                effectively used
                since the late 1980s, with FDA and CE-marked approvals for several neurological and psychiatric
                disorders,
                ensuring its credibility and reliability as a treatment option.

            </p>
            <Heading3>Here’s how it works</Heading3>
            <ol>
                <li><span class="font-bold">Implantation:</span> During surgery, thin electrodes are carefully placed in
                    precise
                    locations in the brain. These locations are chosen based on the condition being treated. For
                    addiction, the
                    electrodes are placed in areas involved in reward, motivation and decision making.
                </li>
                <li><span class="font-bold">Device Connection:</span> The electrodes are connected to a small
                    battery-powered
                    device called a pulse generator, which is usually implanted under the skin near the collarbone. This
                    device
                    sends electrical impulses to the brain.
                </li>
                <li><span class="font-bold">Stimulation:</span> The electrical impulses from the pulse generator help
                    regulate
                    abnormal brain activity. In the case of addiction, these impulses may help reduce cravings and
                    improve
                    self-control by modulating brain circuits involved in these behaviours.
                </li>
                <li><span class="font-bold">Adjustment:</span> After the surgery, doctors can adjust the settings of the
                    device
                    to ensure it provides the most benefit. This process is usually done through a wireless connection
                    to the
                    pulse generator.
                </li>
            </ol>
            <p>This treatment is reversible and adjustable, making it a flexible option for managing chronic conditions.
                By
                understanding and harnessing the brain’s electrical signals, DBS offers a way to improve the quality of
                life for
                many patients.
            </p>
            <Heading2>Scope and collaborators</Heading2>
            <p>Brain-PACER is a large multicentre study conducted throughout the UK. Led by Professor Valerie Voon of
                the Voon
                Lab at the University of Cambridge Department of Psychiatry, the study is funded by the Medical Research
                Council
                (MRC) and operates under ethics approval of the Cambridge University Hospital and University of
                Cambridge. In
                collaboration with Kings College Hospital, the Institute of Psychiatry, Psychology, and Neuroscience
                (IoPPN) at
                King’s College London, under the South London and Maudsley (SLaM) NHS Foundation Trust, and the
                University of
                Oxford, this study spans multiple institutions known for their high-quality research.</p>
            <Heading2>Participation Information</Heading2>
            <Heading3>Recruitment Target</Heading3>
            <p>We are seeking participants for a research study focusing on Alcohol Use Disorder (AUD) and Opioid Use
                Disorder
                (OUD). Our target is to recruit 6 individuals with AUD and 6 individuals with OUD.
            </p>
            <Heading3>Inclusion Criteria</Heading3>
            <p>To be eligible for participation in this study, individuals must meet the following criteria:
            </p>
            <ul>
                <li><span class="font-bold">Age:</span> 18 – 60 years old</li>
                <li><span class="font-bold">Diagnosis:</span> Diagnosed with AUD or OUD according to DSM-5 criteria</li>
                <li><span class="font-bold">Duration of Disorder:</span> A minimum of 5 years with the disorder</li>
                <li><span class="font-bold">Abstinence Attempts:</span> At least 3 failed attempts at abstinence</li>
                <li><span class="font-bold">Previous Treatments:</span> Failed psychotherapy and standard
                    pharmacotherapy
                </li>
            </ul>
            <Heading3>Exclusion Criteria</Heading3>
            <p>Participants will be excluded from the study if they meet any of the following conditions:
            </p>
            <ul>
                <li><span class="font-bold">Serious Psychiatric Disorders:</span> Includes conditions such as
                    schizophrenia or
                    bipolar disorder
                    (However, comorbidities like moderate depression, OCD, and anxiety disorders are acceptable)
                </li>
                <li><span class="font-bold">Substance Use:</span> Other substance use disorders are acceptable if AUD or
                    OUD is
                    the primary
                    diagnosis
                </li>
                <li><span class="font-bold">Substitution Therapy:</span> Can be on opioid substitution therapy with
                    occasional
                    breakthroughs (up
                    to 1 per week or 5 per month)
                </li>
                <li><span class="font-bold">Neurosurgical Contraindications:</span> Such as inability to tolerate
                    general
                    anaesthesia or high risk
                    of bleeding
                </li>
                <li><span class="font-bold">Medical History:</span> History of repeated falls, major head injury, marked
                    cognitive impairment,
                    cortical atrophy, or end-stage liver disease (advanced cirrhosis)
                </li>
            </ul>

            <Heading3>Ideal Candidate Profile</Heading3>
            <p>We are looking for reliable and motivated individuals who:
            </p>
            <ul>
                <li><span class="font-bold">Commitment:</span> Are consistent in attending follow-ups and highly
                    motivated to
                    quit their addiction
                </li>
                <li><span class="font-bold">Challenges:</span> Have faced repeated relapses despite adequate therapy
                </li>
            </ul>
            <Heading2>Benefits of Participation</Heading2>
            <p>Participating in our deep brain stimulation (DBS) study for treatment-refractory or severe alcohol use
                disorder
                or opioid use disorder offers several potential benefits:

            </p>
            <Heading3>
                Benefits of Participation
            </Heading3>
            <ul>
                <li><span class="font-bold">Innovative Treatment</span>: Gain access to cutting-edge DBS therapy, which
                    may
                    provide relief from addiction symptoms when other treatments have failed.
                </li>
                <li><span class="font-bold">Comprehensive Care</span>: Benefit from comprehensive medical and
                    psychological
                    support throughout the study.
                </li>
                <li><span class="font-bold">Personalised Approach</span>: Receive a personalised treatment plan tailored
                    to your
                    specific needs and monitored by leading experts in the field.
                </li>
            </ul>
            <Heading3>Compensation</Heading3>
            <ul>
                <li><strong>Financial Compensation</strong>: Participants will receive <strong>£500</strong> in
                    financial
                    compensation for their time and effort in contributing to this important research. Further
                    compensation will
                    cover travel expenses and time spent participating in study-related activities.
                </li>
                <li><strong>Medical Evaluations</strong>: Participants will undergo thorough medical evaluations at no
                    cost,
                    providing insights into their overall health and potential areas for medical attention.
                </li>
            </ul>
            <Heading3>Contribution to Science</Heading3>
            <ul class="wp-block-list">
                <li><strong>Advancement of Knowledge</strong>: Your participation will contribute significantly to
                    scientific
                    understanding and advancements in the treatment of addiction. The data collected will help
                    researchers
                    develop more effective treatments for those struggling with severe addictions.
                </li>
                <li><strong>Future Impact</strong>: By participating, you help pave the way for future patients to
                    receive
                    better care and treatment options, potentially transforming addiction therapy.
                </li>
            </ul>
            <p>Your involvement in this study is crucial. By participating, you are not only helping yourself but also
                contributing to a broader effort to combat addiction and improve the lives of countless others facing
                similar
                challenges.
            </p>
            <Heading2>Interested in Participating?</Heading2>
            <p>We welcome individuals who are interested in contributing to groundbreaking research on addiction
                treatment
                through deep brain stimulation (DBS). Here’s how you can enrol in the Brain-PACER study:
            </p>
            <ol>
                <li><strong>Check Eligibility</strong>
                    <ul class="wp-block-list">
                        <li>Review the inclusion and exclusion criteria listed on our Eligibility Criteria page to
                            determine if
                            you qualify for the study.
                        </li>
                    </ul>
                </li>
                <li><strong>Contact Us</strong>
                    <ul class="wp-block-list">
                        <li>If you meet the eligibility criteria, please speak with your addiction therapy team and
                            reach out to
                            our recruitment team via email at recruitment@brain-pacer.com. Our team will guide you
                            through the
                            initial steps and answer any questions you may have.
                        </li>
                    </ul>
                </li>
            </ol>
            <Heading2>Study Sites</Heading2>
            <p><strong>Cambridge Site: Addenbrooke’s Hospital</strong><br><strong>Address:</strong> Department of
                Psychiatry,
                University of Cambridge, Addenbrooke’s Hospital, Hills Rd, Cambridge CB2 0QQ, United Kingdom</p>

            <p><strong>London Site: King’s College Hospital (KCH)</strong><br><strong>Address:</strong> King’s College
                Hospital,
                Denmark Hill, London SE5 9RS, United Kingdom</p>

            <Heading2>Research Team</Heading2>

            <div class="grid grid-cols-1 lg:grid-cols-2 gap-4 mt-5">
                <!--                <div v-for="teamMember in teamMembers" class="bg-white rounded-lg p-3 ring-1 ring-slate-200 min-h-32">-->
                <!--                    <div class="flex flex-row">-->
                <!--                        <div class="min-w-32"></div>-->
                <!--                        <div class="flex-col grow">-->
                <!--                            <div>{{ teamMember.name }}<template v-for="credential in teamMember.credentials">, {{ credential }}</template></div>-->
                <!--                            <div v-for="position in teamMember.positions" class="text-slate-400 text-sm">{{ position }}</div>-->
                <!--                        </div>-->
                <!--                    </div>-->
                <!--                </div>-->
                <div v-for="teamMember in teamMembers" class="bg-white rounded-lg ring-1 ring-slate-200 leading-snug">
                    <div class="flex flex-col rounded-lg">
                        <div class="flex flex-row gap-3 pt-3 px-3">
                            <div class="min-w-20 flex flex-row justify-center">
                                <div class="bg-slate-100 rounded size-20 ring-1 ring-slate-400">
                                    <img v-if="teamMember.photoUrl" :src="teamMember.photoUrl"
                                         alt="Photo of {{ teamMember.name }}" class="rounded size-20 leading-none">
                                </div>
                            </div>
                            <div class="flex-col grow">
                                <div class="mt-[-3px] text-slate-800 text-sm lg:text-lg">
                                    {{ teamMember.name }}<template v-for="credential in teamMember.credentials">, {{ credential }}</template>
                                </div>
                                <div v-for="position in teamMember.positions" class="text-slate-400 text-xs lg:text-sm">
                                    {{
                                        position
                                    }}
                                </div>
                            </div>
                        </div>
                        <div
                            class="py-2 px-3 rounded-b-lg text-violet-400 justify-end w-full text-left flex flex-row text-xs lg:text-sm">
                            {{ teamMember.organization }}
                        </div>
                    </div>
                </div>
            </div>

            <p></p>
            <p></p>
            <p></p>
            <p></p>
            <p></p>
            <p></p>
            <p></p>
            <p></p>
            <p></p>
            <p></p>
            <p></p>
            <p></p>
            <p></p>
            <p></p>
            <p></p>
            <p></p>
            <p></p>
            <p></p>
            <p></p>
            <p></p>
            <p></p>
            <p></p>
            <p></p>
            <p></p>
            <p></p>
            <p></p>
            <p></p>
            <p></p>

        </div>
    </div>
</template>

